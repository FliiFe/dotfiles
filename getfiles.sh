#!/bin/fish
# A script that gets my dotfiles and puts them in this repo

set lasttask ''
function done_task
    test "$argv[1]" -eq 0; and echo -e "\e[1;32m✓\e[0m"; or echo -e '\e[1;31m✗\e[0m' $lasttask
end

function new_task
    echo -ne ' ' $argv '\r'
    set lasttask $argv
end

cd (dirname (status -f))

# Make a backup in /tmp in case the script goes wrong
tar czf /tmp/dotfiles-(date +'%y-%m-%d-%H:%M:%S').tar.gz * .*

# Ask for confirmation
git rev-parse --git-dir 2>/dev/null >/dev/null; and set isgit '\e[32m is'; or set isgit '\e[31m is not'
read -P (printf 'Current directory is \e[32m'(pwd)'\e[0m;, and'$isgit' a git repository\e[0m. Delete current dotfiles ? (delete/abort) ') answer
if test "$answer" = "delete"
    new_task 'Removing current dotfiles'
    rm -rf dotfiles
    done_task "$status"
else
    echo 'Aborting.'
    exit
end

mkdir dotfiles
cd dotfiles

## Vim
new_task 'Copying vimrc'
cp ~/.vimrc .
done_task $status
new_task 'Copying vim config'
mkdir -p .vim
cp -r ~/.vim/{init.vim,plug.vim} .vim
done_task $status

## Tmux
new_task 'Copying tmux config file'
cp ~/.tmux.conf .
done_task $status

## i3
new_task 'Copying i3 config file'
mkdir -p .config/i3
cp ~/.config/i3/config .config/i3/config
done_task $status

## polybar
new_task 'Copying polybar config file'
mkdir -p .config/polybar
cp ~/.config/polybar/{config,weather} .config/polybar/
done_task $status

## fish
new_task 'Copying fish config'
mkdir -p .config/fish
cp -r ~/.config/fish/{config.fish,functions} .config/fish/
done_task $status

## urxvt & rofi
new_task 'Copying rofi and urxvt config (Xresources)'
cp ~/.Xresources .
done_task $status

## xsession
new_task 'Copying xprofile'
cp ~/.xprofile ~/.xinitrc .
done_task $status
