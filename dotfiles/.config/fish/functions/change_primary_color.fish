function change_primary_color
    test -n "$argv[1]"; or return 1

    echo "$argv[1]" >~/.primary

    set -gx primary "$argv[1]"
    set -gx fish_color_command $primary
    set -gx fish_color_escape $primary
    set -gx fish_color_end $primary

    tmux set -g pane-active-border-fg $primary
    tmux refresh-client

    clear
end
