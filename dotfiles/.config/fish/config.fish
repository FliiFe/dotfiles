set -gx VISUAL "nvim"
set -gx EDITOR "nvim"
set -gx pathdirs $HOME/bin $HOME/.npm-global/bin /usr/local/bin $PATH /usr/local/go/bin $GOPATH $HOME/.local/bin $HOME/.gem/ruby/2.1.0/bin
set -gx GPG_TTY (tty)
set primary (cat ~/.primary)

for dir in $pathdirs;
    test -d $dir; and set -gx PATH $PATH $dir
end

if status --is-interactive
    # Base16 Colourscheme
    cat $HOME/.config/base16-shell/scripts/base16-eighties.sh | sed \
        's/^\(.*\)background/printf "" #\1background/g' | sh
    [ (tty) = "/dev/tty1" ]; and [ "$DISPLAY" = "" ]; and exec startx

    if [ "$TMUX" = "" ]
        command -v tmux; and exec tmux -2
    end

    # function hybrid_bindings --description "Vi-style bindings"
    #     for mode in default insert visual
    #         fish_default_key_bindings -M $mode
    #     end
    #     fish_vi_key_bindings --no-erase
    # end
    # set -g fish_key_bindings hybrid_bindings

    set -gx fish_color_normal white
    set -gx fish_color_command $primary
    set -gx fish_color_param white
    set -gx fish_color_quote yellow
    set -gx fish_color_escape $primary
    set -gx fish_color_redirection blue
    set -gx fish_color_end $primary
    set -gx fish_color_autosuggestion 808080

    set -gx GOPATH ~/gowork
    abbr --add j "jump"
    abbr --add l "ls -la"
    abbr --add lah "ls -lah"
    abbr --add gst "git status"
    abbr --add gph "git push"
    abbr --add gpl "git pull"
    abbr --add ga "git add"
    abbr --add gc "git commit"
    abbr --add gd "git diff"
    abbr --add eav "sudo emerge -av"
    abbr --add ecav "sudo emerge -cav"
    abbr --add es "sudo emerge --sync"
    abbr --add eup "sudo emerge -DNuva @world"
    abbr --add remote "env TMUX= urxvtc -e bash ~/bin/remote.sh"
end

