# Set ocfs2 Volume

When kernel is upgraded, there is possibility of not being able to access ocfs2 volume.
e.g. '/media/extdisk0'.

Please install the following package, selecte the kernel version accordingly and reboot.
It is required as it need a module for ocfs2 to be install in the kernel.

```
$ sudo apt-get install \
    linux-image-4.15.0-50-generic \
    linux-headers-4.15.0-50-generic \
    linux-modules-extra-4.15.0-50-generic \
    linux-hwe-tools-4.15.0-50
```

For selecting the kernel version, please refer to [set_default_kernel](set_default_kernel.md)
