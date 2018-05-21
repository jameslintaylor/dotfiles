# wallpaper
~/.fehbg &

# merge & Load configuration from .Xresources
xrdb -merge ~/.Xresources

# keys
~/.keys/reload-keys

# function keys
xbindkeys

redshift &> /dev/null &
compton -b --config ~/.config/compton.conf &
exec xmonad
