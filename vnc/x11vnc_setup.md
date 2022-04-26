# x11vnc Instructions
This is a note on how to setup x11vnc on a server.
e.g. when a remote server is running 'headless'.

## Setup
1. Install x11vnc
```
$ sudo apt-get install x11vnc
```

2. Create a password for user
```
$ x11vnc -storepasswd
```

3. Start x11vnc by specifying to use password file
```
$ x11vnc -usepw
```

4. Create xorg.conf (http://www.virtualgl.org/Documentation/HeadlessNV), set screeen size accordingly
```
$ sudo nvidia-xconfig -a --use-display-device=None --virtual=1440x900
$ sudo nvidia-xconfig -a --use-display-device=None --virtual=1920x1200
```

5. Obtain but ID of the GPU
```
$ lspci | grep -i nvidia
00:03.0 VGA compatible controller: NVIDIA Corporation GK104GL [GRID K520] (rev a1)
```

6. Edit xorg.conf to add bus ID of the GPU
```
$ sudo vim /etc/X11/xorg.conf
...
Section "Device"
    ...
    BusID     "PCI:0:3:0"
EndSection
...
```

6. Reboot server and proceed with VirtualGL installation instructions
```
$ sudo reboot
```

## Server Start Up
* Example start up commands, also refer to [x11vnc-startup.sh](x11vnc-startup.sh)
```
$ sudo x11vnc -rfbauth ~/.vnc/passwd -display :0 -auth /var/run/lightdm/root/:0 -forever -bg -repeat -nowf -rfbport 5900
$ sudo x11vnc -rfbauth ~/.vnc/passwd -display :0 -auth /var/run/lightdm/root/:0 -forever -bg -repeat -nowf -rfbport 5901 -geometry 2880x1800
$ sudo x11vnc -rfbauth ~/.vnc/passwd -display :0 -auth /var/run/lightdm/root/:0 -forever -bg -repeat -nowf -rfbport 5902 -geometry 2560x1440
```

* If "failed to start session" prompted when trying to login
```
$ sudo aptget install ubuntu-desktop
```

* To change change setting e.g resolution
```
$ sudo vim /etc/X11/xorg.conf
```

## Client Connection
* Example connection command using vncviewer
```
$ vncviewer xxx.xxx.xxx.com:5900
```

# Secure Connection
* Example security type flag by vncserver insead of x11vnc
```
$ vncserver $DISPLAY -depth 24 -geometry 1600x1000 -SecurityTypes=VeNCrypt, TLSVnc
```

* Example secure SSH tunnelling instead of vncserver. From a client pc, setup a SSH forwarding port (localhost:5092 to remotehost:5901):
```
$ ssh -L 5902:127.0.0.1:5901 user@XXXX.XXXX.com
```

* After login from SSH, start x11vnc server as usual with -localhost flag:
```
$ sudo x11vnc -rfbauth ~/.vnc/passwd -display :0 -auth /var/run/lightdm/root/:0 -forever -bg -repeat -nowf -localhost -rfbport 5901 -geometry 2560x1440
```

* In another terminal from client, start vncviewer:
```
$ vncviewer localhost:5902
```

* To test, these should NOT work:
```
$ vncviewer user@XXXX.XXXX.com:5901
```

## Note for Macos
For Macos, there is built-in program for remote display.
```
Right click on 'Finder' > click 'Connect to server...' > enter server address accordingly
e.g vnc://localhost:5902
```
