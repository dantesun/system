#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
export LC_CTYPE="zh_CN.UTF-8"
#export XMODIFIERS=@im=SCIM
#export GTK_IM_MODULE="scim"
#export QT_IM_MODULE="scim"
#scim -d
#exec ck-launch-session startxfce4
#exec openbox-session
#exec ck-launch-session startlxde
#exec openbox-lxde
#urxvt-tabbed &
#exec scrotwm
#exec awesome
exec wmii 
#export AWT_TOOLKIT=XToolkit
# Set background color
xsetroot -solid "#333333"
#exec /usr/bin/i3 -V -d all >> ~/.i3/logfile
#exec /usr/bin/i3 
xscreensaver -nosplash &
