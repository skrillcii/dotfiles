# Docker
Try out the minimal dotfile customization in a docker container.

## Table of Contents
1. [Setup](#setup)
1. [Install](#install-docker-compose)
1. [Note](#note)

## Setup
1. Build the image.
`docker build -t ubuntu:admin .`

2. Start the container with user `admin`.
`docker -it --user admin ubuntu:admin`

3. Manually build dotfile customization.
`./dotfiles/scripts/install_linux_base.sh`

4. Commit container to retain the state.
`docker commit IMAGE_ID ubuntu:admin`

## Upgrade Docker Compose
1. Remove the old version:
If installed via apt-get
`sudo apt-get remove docker-compose`
If installed via curl
`sudo rm /usr/local/bin/docker-compose`
If installed via pip
`pip uninstall docker-compose`

2. Set desired version and install path
```
VERSION=1.28.0
DESTINATION=/usr/local/bin/docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m) -o ${DESTINATION}
sudo chmod +x ${DESTINATION}
```

3. Check version
```
docker-compose -v
```

## Notes
This way of setup is not ideal as in the above step 3, changes are not permanent.
There are several ways to go about this.
* Build dotfile content in dockerfiles directly.
* Run install script with root before non-root-user setup in dockerfiles.
* Use docker commit after step 3 to update the existing images.
