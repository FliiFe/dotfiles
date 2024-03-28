function mark --description 'mark <mark-name> # Creates a mark at PWD with given name'
	mkdir -p ~/.config/marks
	ln -s (pwd) ~/.config/marks/"$argv[1]"
end
