# Monitor
This docs is as a saved reference for system control and monitoring commands

## Commands
Turn on ranger
```
$ ranger
```

Turn on glances
```
$ glances
```

Turn on htop
```
$ htop
```

Turn on nvidia-smi 
```
$ nvidia-smi -l
```

Turn on redshift
```
$ redshift
```

Turn on nautilus
```
$ nautilus --no-desktop
```

Watch cpu(s) core temperature
```
$ watch -n 5 "sensors"
```

Watch wifi channel activity
```
$ watch -n 5 "nmcli d wifi"
```

Watch network ports
```
$ watch -n 5 "sudo lsof -i -P -n | grep LISTEN"
```
