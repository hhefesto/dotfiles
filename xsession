#!/bin/bash

# Load resources
xrdb -merge .Xresources

# Set up an icon tray
#trayer --edge top --align right --SetDockType true --SetPartialStrut true \
# --expand true --width 10 --transparent true --tint 0x191970 --height 12 &

# No funciona
# Set the background color
# xsetroot -solid midnightblue

# Fire up apps

# no sé si esté funcionando.
# xscreensaver -no-splash &

# no funciona
# if [ -x /usr/bin/nm-applet ] ; then
#    nm-applet --sm-disable &
# fi
# no funciona
# if [ -x /usr/bin/gnome-power-manager ] ; then
#    sleep 3
#    gnome-power-manager &
# fi

# prueba no superada...
# export PRUEBA="Hola, Prueba."

# xpmroot ~/Pictures/background_xmonad.jpg &

# exec xmonad

# Startup

if [ pgrep -x "google-chrome" > /dev/null ] || [ pgrep -x "emacs" > /dev/null ] || [ pgrep -x "gnome-control-center" > /dev/null ]
then
    emacs  2>&1 &
    gnome-control-center  2>&1 &
    google-chrome 2>&1 &
fi

# Clear
clear
