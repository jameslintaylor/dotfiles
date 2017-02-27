# tmux plz
# echo $TERM | grep -qv '^screen'; and exec tmux

function swap 
	set tmp $argv[1].tmp
	cp $argv[1] $tmp
	mv $argv[2] $argv[1]
	mv $tmp $argv[2]
end
