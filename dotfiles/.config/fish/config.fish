set -gx VISUAL "nvim"
set -gx EDITOR "nvim"
set -g fish_user_paths $HOME/bin $HOME/.npm-global/bin /usr/local/go/bin $HOME/.local/bin $HOME/.gem/ruby/2.3.0/bin $HOME/.cargo/bin $HOME/Mathematica/bin $HOME/gowork/bin $HOME/flutter/bin $HOME/android/tools/bin
# Dirty hack
# set -gx PATH $HOME/android/platform-tools/ $PATH
set -gx GPG_TTY (tty)
set primary (cat ~/.primary)

if status --is-interactive
    # [ (tty) = "/dev/tty2" ]; and [ "$DISPLAY" = "" ]; and exec startx
    
    if [ (tty | string sub -s 1 -l 8) != "/dev/tty" ];
        if [ "$TMUX" = "" ]
            command -v tmux; and exec tmux -2
        end
        # Base16 Colourscheme
        cat $HOME/.config/base16-shell/scripts/base16-eighties.sh | sed \
            's/^\(.*\)background/printf "" #\1background/g' | sh
    end



    set -gx fish_color_normal white
    set -gx fish_color_command $primary
    set -gx fish_color_param white
    set -gx fish_color_quote yellow
    set -gx fish_color_escape $primary
    set -gx fish_color_redirection $primary
    set -gx fish_color_end $primary
    set -gx fish_color_autosuggestion 808080

    set -gx GOPATH ~/gowork
    # abbr --add --global j "jump"
    abbr --add --global l "ls -la"
    abbr --add --global lah "ls -lah"
    abbr --add --global gst "git status"
    abbr --add --global gph "git push"
    abbr --add --global gpl "git pull"
    abbr --add --global ga "git add"
    abbr --add --global gc "git commit"
    abbr --add --global gd "git diff"
    abbr --add --global eav "sudo emerge -av"
    abbr --add --global ecav "sudo emerge -cav"
    abbr --add --global es "sudo emerge --sync"
    abbr --add --global eup "sudo emerge -DUuva @world"
    abbr --add --global e "sudo emerge"
    abbr --add --global eq "sudo emerge -q"
    abbr --add --global remote "setsid env TMUX= alacritty -e bash ~/bin/remote.sh"
    
    # OPAM configuration
    source /home/fliife/.opam/opam-init/init.fish > /dev/null 2> /dev/null or true
end

