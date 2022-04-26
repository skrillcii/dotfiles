# Set Default Kernel
This is a note on how to set default kernel when desired.
e.g. when updated kernel does not work well, you may want to revert to older ones.

## Instructions
1. Good-old backup
```
$ sudo cp /etc/default/grub /etc/default/grub.bak
```

2.  Edit configuration
```
$ sudo vim /etc/default/grub
```

3. Find the `$menuentry_id_option` for the submenu
```
$ grep submenu /boot/grub/grub.cfg
submenu 'Advanced options for Ubuntu' $menuentry_id_option 'gnulinux-advanced-732c32b4-4022-44c2-a64c-c5b48c470e46'
```

4. Find the `$menuentry_id_option` for the kernel entry you want to use
```
$ grep menuentry /boot/grub/grub.cfg
if [ x"${feature_menuentry_id}" = xy ]; then
  menuentry_id_option="--id"
  menuentry_id_option=""
export menuentry_id_option
menuentry 'Ubuntu' --class ubuntu --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-simple-732c32b4-4022-44c2-a64c-c5b48c470e46' {
submenu 'Advanced options for Ubuntu' $menuentry_id_option 'gnulinux-advanced-732c32b4-4022-44c2-a64c-c5b48c470e46' {
        menuentry 'Ubuntu, with Linux 5.4.0-53-generic' --class ubuntu --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-5.4.0-53-generic-advanced-732c32b4-4022-44c2-a64c-c5b48c470e46' {
        menuentry 'Ubuntu, with Linux 5.4.0-53-generic (recovery mode)' --class ubuntu --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-5.4.0-53-generic-recovery-732c32b4-4022-44c2-a64c-c5b48c470e46' {
        menuentry 'Ubuntu, with Linux 5.4.0-47-generic' --class ubuntu --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-5.4.0-47-generic-advanced-732c32b4-4022-44c2-a64c-c5b48c470e46' {
        menuentry 'Ubuntu, with Linux 5.4.0-47-generic (recovery mode)' --class ubuntu --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-5.4.0-47-generic-recovery-732c32b4-4022-44c2-a64c-c5b48c470e46' {
        menuentry 'Ubuntu, with Linux 5.4.0-42-generic' --class ubuntu --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-5.4.0-42-generic-advanced-732c32b4-4022-44c2-a64c-c5b48c470e46' {
        menuentry 'Ubuntu, with Linux 5.4.0-42-generic (recovery mode)' --class ubuntu --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-5.4.0-42-generic-recovery-732c32b4-4022-44c2-a64c-c5b48c470e46' {
menuentry 'Windows Boot Manager (on /dev/sda1)' --class windows --class os $menuentry_id_option 'osprober-efi-B8E3-E47E' {
menuentry 'UEFI Firmware Settings' $menuentry_id_option 'uefi-firmware' {
```

5. Replace `GRUB_DEFAULT=0` with the submenu's `$menuentry_id_option` from step 3, and the selected kernel's `$menuentry_id_option` from step 4 separated by "`>`"
```
GRUB_DEFAULT="gnulinux-advanced-732c32b4-4022-44c2-a64c-c5b48c470e46>gnulinux-5.4.0-42-generic-advanced-732c32b4-4022-44c2-a64c-c5b48c470e46"
```

6. Update grub
```
$ sudo update-grup
```

7. Check loaded kernel after reboot
```
$ uname -a
```

## Additional Option:
Save last entry option
```
GRUB_SAVEDEFAULT=true
GRUB_DEFAULT=saved
```

## References
[StackExchange - set-default-kernel-in-grub](https://unix.stackexchange.com/questions/198003/set-default-kernel-in-grub)
