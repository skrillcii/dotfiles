# Upgrade or Remove Kernel
This is a note on how to upgrade and remove kernels.
e.g. when there is security patch update, or boot partition space is running low.

## Instructions - To Remove
1. Check the current kernel version
```
$ uname -r
```

2. Listing installed kernels
```
$ sudo dpkg --list 'linux-image*'|awk '{ if ($1=="ii") print $2}'|grep -v `uname -r`
linux-image-3.19.0-59-generic
linux-image-3.19.0-61-generic
linux-image-3.19.0-65-generic
linux-image-extra-3.19.0-59-generic
linux-image-extra-3.19.0-61-generic
```

3. Remove kernels
```
$ sudo apt-get purge linux-image-3.19.0-59-generic
$ sudo apt-get purge linux-image-3.19.0-61-generic
$ sudo apt-get purge linux-image-3.19.0-65-generic
```

4. Then done removing, run `autoremove` to clean up
```
$ sudo apt-get autoremove
```

5. Lastly, update grub 
``` 
$ sudo update-grub 
```

## Instructions - To Upgrade
1. Generally, when upgrading kernel, make sure to install
```
$ sudo apt-get install 
linux-image-X.X.X-YYY-generic 
linux-headers-X.X.X-YYY-generic 
linux-modules-extra-X.X.X-YYY-generic 
linux-hwe-tools-X.X.X-YYY
```

## Useful Commands
```
$ lsmod | grep -i whatever
$ lspci | grep -i whatever
$ dpkg -l | grep -i whatever
```

## References
[GitHub - ipbastola/clean-up-boot-parition-ubuntu.md](https://gist.github.com/ipbastola/2760cfc28be62a5ee10036851c654600)
