function jump --description 'jump <markname>'
	cd (readlink ~/.config/marks/"$argv[1]")
end
