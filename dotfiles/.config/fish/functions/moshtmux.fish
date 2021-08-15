function moshtmux
    setsid alacritty -e fish -c "cat $HOME/.config/base16-shell/scripts/base16-eighties.sh | sed 's/^\(.*\)background/printf \"\" #\1background/g' | sh; mosh $argv tmux"
end
