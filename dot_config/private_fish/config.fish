if status is-interactive
    type -q starship; and starship init fish | source
    type -q pyenv; and pyenv init - | source
    type -q keychain; and eval (keychain --eval --quiet);
end
