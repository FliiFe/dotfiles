set -gx VISUAL "nvim"
set -gx EDITOR "nvim"
set -gx pathdirs $HOME/bin $HOME/.npm-global/bin /usr/local/bin $PATH /usr/local/go/bin $GOPATH $HOME/.local/bin $HOME/.gem/ruby/2.1.0/bin
set -gx GPG_TTY (tty)
set primary (cat ~/.primary)

for dir in $pathdirs;
    test -d $dir; and set -gx PATH $PATH $dir
end

# Base16 Colourscheme
if status --is-interactive
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
    alias j="jump"
    alias l="ls -la"
    alias lah="ls -lah"
    alias gst="git status"
    alias gph="git push"
    alias gpl="git pull"
    alias ga="git add"
    alias gc="git commit"
    alias gd="git diff"
    alias eav="sudo emerge -av"
    alias es="sudo emerge --sync"
    alias eup="sudo emerge -DNuva @world"
    alias remote 'env TMUX= urxvtc -e bash ~/bin/remote.sh'
end

