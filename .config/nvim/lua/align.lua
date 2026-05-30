-- NOTE: LLM slop ahead
-- BUG: When aligning space " " - gives extra ` ` character
-- BUG: When aligning by space " " - does not ignore indentation
-- BUG: Aligning via operator_key does nothing
--
-- Align lines by a chosen token character.
--
-- ── Quick start ─────────────────────────────────────────────────────────────
--
--   -- In your init.lua:
--   require("align").setup()
--
-- ── Default keymaps ──────────────────────────────────────────────────────────
--
--   Visual mode   <leader>a{char}    align the visual selection by {char}
--   Normal mode   ga{char}{motion}   align the motion / text-object range
--
--   Examples:
--     Visually select lines, press <leader>a=     → align by '='
--     ga=ip                                       → align inner paragraph by '='
--     ga:a{                                       → align a {…} block by ':'
--     ga ip                                       → align inner paragraph by ' '
--
-- ── Customising ──────────────────────────────────────────────────────────────
--
--   require("align").setup({
--     visual_key   = "<leader>a",   -- default (visual mode prefix)
--     operator_key = "ga",          -- default (shadows the built-in 'ga')
--     left_tokens  = { ":" },       -- tokens that stick left (space goes after)
--   })
--
-- ── Programmatic use ─────────────────────────────────────────────────────────
--
--   local aligned = require("align").align_lines(lines, token)
--
-- ── Notes ────────────────────────────────────────────────────────────────────
--
--   • Only the FIRST occurrence of the token on each line is used.
--   • Lines that don't contain the token are left unchanged.
--   • The token is treated as a plain string (not a Lua pattern), so
--     characters like '.', '*', '(' etc. work without escaping.
--   • Whitespace tokens skip leading indentation when searching.
--   • "left tokens" (default: ':') glue to the key — space goes on the right.
--   • "right tokens" (default: everything else) get one space on the left.

local M = {}

-- ── Module state ──────────────────────────────────────────────────────────────

-- Token stored between the normal-mode keymap and the operatorfunc callback.
local pending_token = nil

-- Lookup table of tokens that should stick to the LEFT of the alignment gap
-- (i.e. padding goes on the right side, after the token).
-- Populated from setup()'s left_tokens option; default: { ":" }.
local left_tokens = { [":"] = true }

-- ── Token search ──────────────────────────────────────────────────────────────

--- Find the first occurrence of `token` in `line`, returning its byte position.
--- For pure-whitespace tokens the search starts AFTER any leading indentation,
--- so that indented blocks are not split at their own indent spaces.
---@param  line   string
---@param  token  string
---@return integer|nil
local function find_col(line, token)
  if token:match("^%s+$") then
    -- Skip past leading whitespace (indentation) before looking for the token.
    local content_start = line:match("^%s*()")   -- position of first non-space char
    return line:find(token, content_start, true)
  end
  return line:find(token, 1, true)
end

-- ── Core alignment ────────────────────────────────────────────────────────────

--- Align a list of strings by `token`.
---
--- Behaviour depends on whether the token is in `left_tokens`:
---
---   Right-side tokens (e.g. '='):  one space is inserted to the LEFT of the
---     token so that all tokens land in the same column.
---       foo = 1       →   foo        = 1
---       longer_key = 2    longer_key = 2
---
---   Left-side tokens (e.g. ':'):   the token glues to its prefix; padding is
---     inserted to the RIGHT so that all suffixes start in the same column.
---       name: "Alice"     →   name:       "Alice"
---       occupation: "Dev"     occupation: "Dev"
---
---   Whitespace tokens (e.g. ' '):  the token itself acts as the separator —
---     no extra space is added on either side.
---       foo bar       →   foo        bar
---       longer_key baz    longer_key baz
---
---@param lines  string[]
---@param token  string    plain text, not a Lua pattern
---@return       string[]  same length as input
local function align_lines(lines, token)
  local is_left  = left_tokens[token] == true
  local is_space = (not is_left) and (token:match("^%s") ~= nil)

  -- ── Pass 1: measure the "anchor" column ────────────────────────────────
  -- For right/space tokens:  anchor = width of the stripped prefix.
  -- For left tokens:         anchor = width of (prefix + token) together,
  --                          because the gap goes AFTER the token.
  local max_anchor = 0
  local any_match  = false

  for _, line in ipairs(lines) do
    local col = find_col(line, token)
    if col then
      any_match = true
      local prefix = line:sub(1, col - 1):gsub("%s+$", "")
      local anchor = is_left and (#prefix + #token) or #prefix
      if anchor > max_anchor then max_anchor = anchor end
    end
  end

  if not any_match then return lines end

  -- ── Pass 2: rebuild with uniform spacing ───────────────────────────────
  local out = {}
  for _, line in ipairs(lines) do
    local col = find_col(line, token)
    if col then
      local prefix = line:sub(1, col - 1):gsub("%s+$", "")
      -- suffix: everything that comes AFTER the token (token itself excluded).
      local suffix = line:sub(col + #token)

      local new_line
      if is_left then
        -- Token sticks left: emit  prefix · token · gap · suffix
        -- Strip the original space(s) right after the token; we'll re-add one.
        suffix = suffix:gsub("^%s+", "")
        local gap = string.rep(" ", max_anchor - (#prefix + #token) + 1)
        new_line = prefix .. token .. gap .. suffix

      elseif is_space then
        -- Whitespace token: token IS the separator, no extra margin.
        -- Emit  prefix · gap · token · suffix
        local gap = string.rep(" ", max_anchor - #prefix)
        new_line = prefix .. gap .. token .. suffix

      else
        -- Regular right-side token: one mandatory space to the LEFT.
        -- Emit  prefix · gap · " " · token · suffix
        local gap = string.rep(" ", max_anchor - #prefix)
        new_line = prefix .. gap .. " " .. token .. suffix
      end

      table.insert(out, new_line)
    else
      table.insert(out, line)
    end
  end

  return out
end

--- Apply alignment to a 0-indexed line range in `buf`.
---@param buf    integer
---@param s      integer  start line, 0-indexed inclusive
---@param e      integer  end   line, 0-indexed inclusive
---@param token  string
local function apply(buf, s, e, token)
  local lines   = vim.api.nvim_buf_get_lines(buf, s, e + 1, false)
  local aligned = align_lines(lines, token)
  vim.api.nvim_buf_set_lines(buf, s, e + 1, false, aligned)
end

-- ── Input helper ──────────────────────────────────────────────────────────────

--- Show a minimal prompt and wait for exactly one keystroke.
--- Returns nil on <Esc>, errors, or non-printable/special keys.
---@return string|nil
local function read_token()
  vim.api.nvim_echo({ { "align » ", "Question" } }, false, {})
  local ok, raw = pcall(vim.fn.getchar)
  vim.cmd("echo ''")   -- clear the prompt
  if not ok then return nil end
  if type(raw) == "number" then
    if raw == 27 then return nil end   -- <Esc>
    return vim.fn.nr2char(raw)
  end
  return nil   -- special key string (arrows, F-keys …) → ignore
end

-- ── Operator callback ────────────────────────────────────────────────────────

--- Internal callback called after g@<motion> completes.
--- Defined as a local closure so it always references THIS module's
--- `pending_token`, regardless of how/where the module was require()'d.
--- Exposed globally as _G._align_operator_callback so Neovim can reach it
--- from operatorfunc = "v:lua._align_operator_callback".
local function do_operator(_type)
  if not pending_token then return end
  local token = pending_token
  pending_token = nil   -- consume immediately

  local s = vim.api.nvim_buf_get_mark(0, "[")[1] - 1
  local e = vim.api.nvim_buf_get_mark(0, "]")[1] - 1
  apply(0, s, e, token)
end

-- Also reachable as M.operator_callback for anyone who wants to call it
-- via v:lua.require('align').operator_callback (works when the module is
-- cached under exactly the key 'align').
function M.operator_callback(_type) do_operator(_type) end

-- ── Public API ────────────────────────────────────────────────────────────────

--- Core function exposed for programmatic use.
---@type fun(lines: string[], token: string): string[]
M.align_lines = align_lines

---@class AlignConfig
---@field visual_key?   string    Keymap prefix in visual mode.  Default: "<leader>a"
---@field operator_key? string    Operator key in normal mode.   Default: "ga"
---@field left_tokens?  string[]  Tokens that stick to the left. Default: { ":" }

--- Register keymaps and configure the module.
---@param opts? AlignConfig
function M.setup(opts)
  opts = vim.tbl_deep_extend("force", {
    visual_key   = "<leader>a",
    operator_key = "ga",
    left_tokens  = { ":" },
  }, opts or {})

  -- Build the left_tokens lookup from the option list.
  left_tokens = {}
  for _, t in ipairs(opts.left_tokens) do
    left_tokens[t] = true
  end

  -- Register the operatorfunc callback as a true global so it can be reached
  -- via operatorfunc = "v:lua._align_operator_callback" irrespective of the
  -- require() path the user used to load this module.
  _G._align_operator_callback = do_operator

  -- ── Visual mode: <leader>a{char} ─────────────────────────────────────────
  --
  -- Snapshot both ends of the live selection BEFORE doing anything else
  -- (getpos("v") = anchor, getpos(".") = cursor), then exit visual mode
  -- synchronously so the echo area is available for read_token().
  vim.keymap.set("x", opts.visual_key, function()
    local anchor = vim.fn.getpos("v")
    local cursor = vim.fn.getpos(".")
    local s = math.min(anchor[2], cursor[2]) - 1
    local e = math.max(anchor[2], cursor[2]) - 1

    -- "n" = no-remap, "x" = execute now (synchronous).
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
      "nx", false
    )

    local token = read_token()
    if not token then return end
    apply(0, s, e, token)
  end, { desc = "Align selection by token" })

  -- ── Normal mode operator: ga{char}{motion} ───────────────────────────────
  --
  -- Flow:
  --   1. ga        → prompt appears, user types the token character.
  --   2.            pending_token is set; operatorfunc is armed.
  --   3. g@        → Neovim enters operator-pending mode.
  --   4. <motion>  → Neovim sets '[ / '] marks and calls operatorfunc.
  --   5.            do_operator() reads pending_token and aligns the range.
  vim.keymap.set("n", opts.operator_key, function()
    local token = read_token()
    if not token then return end

    pending_token = token
    vim.o.operatorfunc = "v:lua._align_operator_callback"
    vim.api.nvim_feedkeys("g@", "n", false)
  end, { desc = "Align by token (operator)" })
end

return M
