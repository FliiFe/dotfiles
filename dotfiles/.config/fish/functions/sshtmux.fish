function sshtmux
    setsid alacritty -e ssh -t $argv tmux
end
