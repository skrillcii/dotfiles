# Ticker

## Prerequisite
* Ubuntu 20.04
* Docker 19.0308

## Installation
Docker installation (not recommend)
```
docker run -it --rm achannarasappa/ticker
```

Linux installation (recommend)
```
curl -Ls https://api.github.com/repos/achannarasappa/ticker/releases/latest \
| grep -wo "https.*linux-amd64*.tar.gz" \
| wget -qi - \
&& tar -xf ticker*.tar.gz \
&& chmod +x ./ticker
```

Configuration file
```
$ ln -s ~/dotfiles/ticker/ticker.yaml ~/.ticker.yaml
```

## Reference
[GitHub - achannarasppa/ticker](https://github.com/achannarasappa/ticker/)
