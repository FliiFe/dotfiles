#!/usr/bin/env fish

set patches (realpath ./patches)

cd dotfiles

echo -ne '\e[32mPress \e[4mright arrow\e[0;32m to toggle file\e[0m'

set files (find -type f | cut -d/ -f2- | sort)
set activefiles $files

set done 1

function end_with_files
    echo -e '\e[0;32mCopying files…\e[0m'
    for i in $argv
        mkdir -p (dirname ~/$i)
        cp $i ~/$i
    end
    command -v nvim >/dev/null; and alias vim=nvim
    echo $argv | grep vim >/dev/null;
        and echo 'Installing vim-plug';
        and curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim ^/dev/null
        and echo 'Installing vim plugins'
        and vim +PlugInstall +UpdateRemotePlugins +qa
        and echo "Applying airline patch"
        and cd $HOME/.vim/plugged/vim-airline-themes/
        and git apply <$patches/airline-theme.patch
        and cd -
    if echo $argv | grep fish >/dev/null;
        echo 'Installing omf'
        curl -L https://get.oh-my.fish ^/dev/null | fish
        for module in cd fzf gi gityaw jump vcs wttr
            omf install $module
        end
        echo 'Installing base16-shell'
        git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
    end
    exit 0
end

function readarrow
    # Use bash due to bug in fish wich prevents multiple reads in a row
    bash -c 'read -rsN1 r; echo -n "$r"' | read c1
    # If the pressed key is not an arrow key, do as if it was left arrow to toggle file state
    if test ! "$c1" = (echo -ne "\e");
        switch "$c1"
            case j
                echo -n "B"
            case k
                echo -n "A"
            case h l '' ' '
                echo -n "C"
            case q
                clear
                exit 0
            case '*'
                echo -n 'undefined'
        end
        return
    end

    bash -c 'read -rsN1 r; echo -n $r' | read c2
    bash -c 'read -rsN1 r; echo -n $r' | read c3
    echo -n "$c1$c2$c3"
end

function toggle
    if test $done -eq 1
        end_with_files $activefiles
        return
    else if ischecked
        set prevactivelist $activefiles
        set activefiles ()
        for file in $prevactivelist
            test "$file" = $files[$position]; or set activefiles $activefiles $file
        end
    else
        set activefiles $activefiles $files[$position]
    end
    highlight
end

function ischecked
    contains $files[$position] $activefiles
end

function highlight
    test $done -eq 0; and echo -ne '\e[30;107m['(ischecked; and echo '✓'; or echo ' ')']\e[0m\r'
end

function unhighlight
    echo -ne '\e[0m['(ischecked; and echo '✓'; or echo ' ')']\e[0m\r'
end

function moveup
    if test $position -gt 1 -a $done -eq 0
        and unhighlight
        and echo -ne "\e[$argv[1]A"
        and set position (math $position - 1)
        and highlight
    else if test $done -eq 1
        echo -ne '\e[0mDone !\r'
        and echo -ne '\e[1A'
        and set done 0
        and highlight
    end
end

function movedown
    if test $position -lt (count $files)
        unhighlight
        and echo -ne '\e[1B'
        and set position (math $position + 1)
        and highlight
    else if test $position -eq (count $files) -a $done -eq 0
        unhighlight;
        and echo -ne '\e[1B'
        and set done 1
        and echo -ne '\e[30;107mDone !\e[0m\r'
    end
end

for i in $files
    echo -ne '\n[✓]' "~/$i"
end

echo -ne '\n\e[30;107mDone !\e[0m\r'

set position (math (count $files) + 0)

while readarrow | read c
    switch $c
        case '*A'
            moveup
        case '*B'
            movedown
        case '*C'
            toggle
    end
end
