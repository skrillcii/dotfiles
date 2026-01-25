## Held backed

- mutter-common:amd64 (42.0-3ubuntu2)
- libmutter-10-0:amd64 (42.0-0ubuntu7)
- gir1.2-mutter-10:amd64 (42.0-3ubuntu2)

## Kept backed

- gnome-remote-desktop:amd64 (42.0-2ubuntu1)
- gnome-shell:amd64 (42.0-2ubuntu1)
- gnome-shell-common:amd64 (42.0-2ubuntu1)

## Commands

To hold package(s)

```
sudo apt-mark hold <package> ...
```

To unhold package(s)

```
sudo apt-mark unhold <package> ...
```

To list held package(s)

```
sudo apt-mark showhold
```

To list upgradable package(s)

```
sudo apt list --upgradable
```
