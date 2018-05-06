#!/usr/bin/env fish
# A script that gets my dotfiles and puts them in this repo

set lasttask ''
function done_task
    test "$status" -eq 0; and echo -e "\e[1;32m✓\e[0m"; or echo -e '\e[1;31m✗\e[0m' $lasttask
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
read -P (printf 'Current directory is \e[32m'(pwd)'\e[0m, and'$isgit' a git repository\e[0m. Delete current dotfiles ? (delete/abort) ') answer
if test "$answer" = "delete"
    new_task 'Remove current dotfiles'
    rm -rf dotfiles
    done_task
else
    echo 'Aborting.'
    exit
end

mkdir dotfiles
cd dotfiles

## Vim
new_task 'vimrc'
cp ~/.vimrc .
done_task

new_task 'vim config'
mkdir -p .vim .config
and cp -r ~/.vim/{init.vim,plug.vim} .vim
and ln -s ../.vim .config/nvim
done_task

## Tmux
new_task 'tmux config file'
cp ~/.tmux.conf .
done_task

## i3
new_task 'i3 config file'
mkdir -p .config/i3
and cp ~/.config/i3/config .config/i3/config
done_task

## i3lock
new_task 'lock script'
mkdir bin
and cp ~/bin/lock bin/lock
done_task

## polybar
new_task 'polybar config file'
mkdir -p .config/polybar
and cp ~/.config/polybar/{config,weather} .config/polybar/
and cp ~/bin/reload-polybar bin/
done_task

## fish
new_task 'fish config'
mkdir -p .config/fish
and cp -r ~/.config/fish/{config.fish,functions} .config/fish/
done_task

## urxvt & rofi
new_task 'rofi and urxvt config (Xresources)'
and cp ~/.Xresources .
done_task

## xsession
new_task 'xprofile'
cp ~/.xprofile .
and ln -s ~/.xprofile .xinitrc
done_task

## fehbg and background
new_task '~/.fehbg and background image'
cp ~/.fehbg .
and cp -L ~/.bg .
done_task

## Git config
new_task 'git config'
cp ~/.gitconfig .gitconfig
done_task

## Jump destinations
new_task 'jump marks'
cp -r ~/.marks .marks
done_task

## Dunst config
new_task 'dunst config'
cp -r ~/.config/dunst .config/dunst
done_task

## Primary color
new_task 'primary color'
cp -r ~/.primary .primary
done_task

## npmrc
new_task 'npmrc'
cp ~/.npmrc .npmrc
done_task

## eslintrc
new_task 'eslint'
cp ~/.eslintrc.json .
done_task

## remote script
new_task 'remote.sh script'
cp ~/bin/remote.sh bin/
done_task

## change bg script
new_task 'change-bg script'
cp ~/bin/change-bg bin/
done_task

## gpg conf
new_task 'gpg conf'
mkdir .gnupg
and cp ~/.gnupg/gpg.conf .gnupg
done_task

## LatexMK config
new_task 'latexmkrc'
cp ~/.latexmkrc ./
done_task

## alacritty config
new_task 'alacritty config'
mkdir -p .config/alacritty
and cp ~/.config/alacritty/alacritty.yml .config/alacritty/alacritty.yml 
done_task

## Cerebro config
new_task 'cerebro config'
mkdir -p .config/Cerebro
and cp ~/.config/Cerebro/{config.json,theme.css} .config/Cerebro/
done_task

## Compton config
new_task 'compton configuration file'
cp ~/.compton.conf ./
done_task
