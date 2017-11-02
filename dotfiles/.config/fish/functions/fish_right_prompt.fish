function fish_right_prompt
    test "$status" = 0; or printf " \e[31m$status\e[0m"
end

