# Network Tools and Commands
This is a documentation on networking tools and commands

## Prerequisite
install nmap, net-tools
```
sudo apt get install nmap net-tools
```

## Useful commands
check open ports
```
sudo lsof -i -P -n | grep LISTEN
```

install nmap, net-tools
```
nmcli d wifi
```

scan network port
```
nmap -sP 192.168.x.x/24
```

scan network device
```
nmap -sT 192.168.x.x/24
```

scan network device, stealth mode
```
nmap -sS 192.168.x.x/24
```

nmap check OS system
```
nmap -O 192.168.x.x/24
```

## Reference
* [Is there a tool like wifi analyzer for ubuntu?](https://askubuntu.com/questions/237777/is-there-a-tool-like-wifi-analyzer-for-ubuntu)
* [How to check if port is in use on Linux or Unix](https://www.cyberciti.biz/faq/unix-linux-check-if-port-is-in-use-command/)
