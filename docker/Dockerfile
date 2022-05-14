###############
# Pre-defined #
###############
FROM ubuntu:focal
LABEL maintainer "admin <admin@email.com>"

ENV PERSONALIZED_USR=admin
ENV PERSONALIZED_UID=1000
ENV PERSONALIZED_GID=1000

ENV TERM=xterm-256color
ENV TZ=Asia/Tokyo
ENV HOME=/home/${PERSONALIZED_USR}
ENV SHELL=/usr/bin/zsh
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NOWARNINGS=yes

###############
# Start Setup #
###############
# Initial setup
RUN apt-get update && \
   apt-get install -y --no-install-recommends apt-utils && \
   apt-get upgrade -y && \
   apt-get install -y lsb-release && \
   apt-get install -y build-essential cmake python3-dev && \
   apt-get install -y software-properties-common && \
   apt-get install -y zsh tmux vim curl wget git man htop && \
   apt-get install -y locales && locale-gen "en_US.UTF-8" && \
   apt-get clean && \ 
   rm -rf /var/lib/apt/lists/*
# Install sudo
RUN apt-get update && \
    apt-get -y install sudo && \
    rm -rf /var/lib/apt/lists/*
# Setup time zone
RUN apt-get update && \
    apt-get -y install tzdata && \
    rm -rf /var/lib/apt/lists/*
RUN rm /etc/localtime && \
    ln -s -f /usr/share/zoneinfo/${TZ} /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata
# Setup ssh client
RUN apt-get update && \
    apt-get -y install openssh-client && \
    rm -rf /var/lib/apt/lists/*

#############
# Customize #
#############
# Add user
RUN useradd -r -m -d ${HOME} -s ${SHELL} -G sudo \
    -u ${PERSONALIZED_UID} ${PERSONALIZED_USR} -p "$(openssl passwd -6 ${PERSONALIZED_USR})"
USER ${PERSONALIZED_USR}
WORKDIR ${HOME}

# Dotfiles
RUN git clone https://github.com/skrillcii/dotfiles.git /home/${PERSONALIZED_USR}/dotfiles

# Exit
CMD ["/usr/bin/bash"]
