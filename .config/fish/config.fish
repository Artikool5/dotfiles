if status is-interactive
    # Commands to run in interactive sessions can go here
    set MANPAGER 'nvim +Man!'
    set -g fish_greeting
end

alias updlog='bat ~/Scripts/update_log.txt'

alias gic='git clone'
alias ez='eza --all --icons --group-directories-first --color --hyperlink'
alias ezl='ez --long'
alias nv=nvim
alias hx=helix
alias mkdir='mkdir -p'
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
set EDITOR nvim
alias nvtest 'NVIM_APPNAME="nvim-test" nvim'

alias fishconf="$EDITOR ~/.config/fish/config.fish"
alias fishsrc='source ~/.config/fish/config.fish'
alias gitconf="$EDITOR ~/.config/git/config"
alias sshconf='~/.ssh/config'
alias nvimconf="z nvim &&$EDITOR ~/.config/nvim/ &&cd -"
alias kanataconf="$EDITOR ~/.config/kanata/kanata.kbd"
alias kittyconf="$EDITOR ~/.config/kitty/kitty.conf"
alias hyprconf="$EDITOR ~/.config/hypr/hyprland.conf"

function convert_audio
    if test (count $argv) -ne 1
        echo "Usage: convert_audio EXTENSION"
        return 1
    end

    set ext $argv[1]
    for f in *.$ext
        set output (string replace -r "\.$ext\$" '.opus' "$f")
        ffmpeg -n -i "$f" -c:a libopus -vbr on -b:a 64k "$output"
        echo $status
        if test $status -eq 0
            trash "$f"
        end
    end
end

function get-audio
    cd "/mnt/Windows/sda Backup/ASMR/" && yt-dlp --cookies-from-browser firefox -x --no-playlist "$argv[1]" && convert_audio m4a && cd -
end

# pnpm
set -gx PNPM_HOME "/home/artem/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

if not string match -q -- $CARGO_HOME/bin/ $PATH
    set -gx PATH $CARGO_HOME/bin/ $PATH
end

if not string match -q -- $HOME/.local/bin/ $PATH
    set -gx PATH $HOME/.local/bin/ $PATH
end

zoxide init fish | source
starship init fish | source
