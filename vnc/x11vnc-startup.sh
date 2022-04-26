#!/bin/zsh


# Cmvgpu3 screen
/usr/bin/x11vnc -rfbauth /home/morikuni/.vnc/passwd -display :0 -auth /var/run/lightdm/root/:0 -forever -bg -repeat -nowf -localhost -rfbport 5900

# Macbook Pro 15inch screen'
/usr/bin/x11vnc -rfbauth /home/morikuni/.vnc/passwd -display :0 -auth /var/run/lightdm/root/:0 -forever -bg -repeat -nowf -localhost -rfbport 5901 -geometry 2880x1800

# ThinkVision 23inch screen
/usr/bin/x11vnc -rfbauth /home/morikuni/.vnc/passwd -display :0 -auth /var/run/lightdm/root/:0 -forever -bg -repeat -nowf -localhost -rfbport 5902 -geometry 2560x1440

