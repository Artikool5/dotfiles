if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias pacinst='sudo pacman -Syu'
alias unpac='sudo pacman -R'
alias nuke='sudo pacman -Rscn'
alias sysupd='sudo pacman -Syyu'
alias pacsrch='pacman -Qs'
alias search="pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse --bind 'enter:execute(pacman -Si {} | less)'"
alias updlog='bat ~/Scripts/update_log.txt'

alias gic='git clone'
alias eza='eza --all --icons --group-directories-first --color always --colour-scale all --hyperlink'
alias nv=nvim
alias hx=helix
alias mkdir='mkdir -p'
alias rm='echo `Use "trash" instead`'
alias grub-update='sudo grub-mkconfig -o /boot/grub/grub.cfg'

function xbox
    xboxdrv \
        --evdev-absmap ABS_X=x1,ABS_Y=y1,ABS_RZ=y2,ABS_Z=x2,ABS_HAT0X=dpad_x,ABS_HAT0Y=dpad_y \
        --axismap -Y1=Y1,-Y2=Y2 \
        --evdev-keymap BTN_TOP=x,BTN_TRIGGER=y,BTN_THUMB2=a,BTN_THUMB=b,BTN_BASE3=back,BTN_BASE4=start,BTN_BASE=lt,BTN_BASE2=rt,BTN_TOP2=lb,BTN_PINKIE=rb,BTN_BASE5=tl,BTN_BASE6=tr \
        --mimic-xpad --silent --deadzone 55 \
        --evdev /dev/input/event$argv[1]
end

alias reflect="sudo reflector --country 'Germany,Russia' --sort rate --verbose --fastest 15 --save /etc/pacman.d/mirrorlist"
alias lute="z lute && source myenv/bin/activate.fish && python -m lute.main && z"

# CONFIGS
set -U EDITOR nvim

alias fishconf="$EDITOR ~/.config/fish/config.fish"
alias fishsrc='source ~/.config/fish/config.fish'
alias gitconf="$EDITOR ~/.config/git/config"
alias nvimconf="$EDITOR ~/.config/nvim/"
alias kanataconf="$EDITOR ~/.config/kanata/kanata.kbd"

alias kittyconf="$EDITOR ~/.config/kitty/kitty.conf"
alias tmuxconf="$EDITOR ~/.config/tmux/tmux.conf"
alias tmuxsrc="tmux source ~/.config/tmux/tmux.conf"
alias wezconf="$EDITOR ~/.config/wezterm/wezterm.lua"
alias hyprconf="$EDITOR ~/.config/hypr/hyprland.conf"
alias alaconf="$EDITOR ~/.config/alacritty/alacritty.toml"
alias hxconf="$EDITOR ~/.config/helix/config.toml"
alias wget="wget --hsts-file='$XDG_DATA_HOME/wget-hsts'" # ???


set -U XDG_DATA_HOME $HOME/.local/share
set -U XDG_CONFIG_HOME $HOME/.config
set -U XDG_STATE_HOME $HOME/.local/state
set -U XDG_CACHE_HOME $HOME/.cache

set -U HISFILE $XDG_STATE_HOME/bash/history
set -U CARGO_HOME $XDG_DATA_HOME/cargo
set -U CUDA_CACHE_PATH $XDG_CACHE_HOME/nv
set -U GNUPGHOME $XDG_DATA_HOME/gnupg
set -U SCREENRC $XDG_CONFIG_HOME/screen/screenrc
set -U GTK2_RC_FILES $XDG_CONFIG_HOME/gtk-2.0/gtkrc
set -U KDEHOME $XDG_CONFIG_HOME/kde
set -U RUSTUP_HOME $XDG_DATA_HOME/rustup
set -U WINEPREFIX $XDG_DATA_HOME/wine
set -U XAUTHORITY $XDG_RUNTIME_DIR/Xauthority

# export MOZ_ENABLE_WAYLAND=1
# export MOZ_WEBRENDER=1
# export XDG_SESSION_TYPE=wayland

# pnpm
set -gx PNPM_HOME "/home/artikool/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

zoxide init fish | source
starship init fish | source
nvm use lts
