# Docker
Try out the minimal dotfile customization in a docker container.

## Table of Contents
1. [Setup](#setup)
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

## Notes
This way of setup is not ideal as in the above step 3, changes are not permanent.
There are several ways to go about this.
* Build dotfile content in dockerfiles directly.
* Run install script with root before non-root-user setup in dockerfiles.
* Use docker commit after step 3 to update the existing images.
