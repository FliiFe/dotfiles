#!/bin/sh
# setterm -blank 0 -powersave off -powerdown 0
xset s off
setxkbmap -option compose:ralt
# eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
redshift -l 50.674520:3.216898 &
# urxvt daemon
urxvtd &
# xrandr --output HDMI-A-0 --auto --output DisplayPort-0 --left-of HDMI-A-0
xrandr --output HDMI-A-0 --auto --output DisplayPort-0 --left-of HDMI-A-0 --output DVI-I-1 --pos 3840x312
# xrandr --output DisplayPort-0 --primary --mode 1920x1080 --pos 0x768 --output DVI-I-1 --mode 1366x768 --pos 1408x0 --output HDMI-A-0 --mode 1920x1080 --pos 1920x768
# Set the background
sh ~/.fehbg
# Start the composer
compton --backend glx --inactive-dim  0.075 --inactive-dim-fixed \
    -f -c -C -z --xinerama-shadow-crop --blur-background --blur-kern 3x3box -t 0 &
eval `ssh-agent`
numlockx on
dunst
exec ck-launch-session dbus-launch --exit-with-session i3
# exec i3
