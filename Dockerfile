FROM phusion/baseimage:master-amd64

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true

# Use baseimage-docker's init system.
CMD ["/bin/bash"]

# ...put your own build instructions here...
RUN apt-get update
RUN apt-get dist-upgrade -yqq
RUN apt-get install -yqq apt-utils sudo
RUN apt-get install -yqq sudo lsb-release apt-transport-https ca-certificates software-properties-common wget curl netcat aria2 whois figlet p7zip p7zip-full zip unzip
RUN apt-get install -yqq language-pack-gnome-en language-pack-gnome-id dirmngr gnupg gnupg2
RUN add-apt-repository ppa:savoury1/build-tools -y
RUN add-apt-repository ppa:savoury1/backports -y
RUN add-apt-repository ppa:savoury1/graphics -y
RUN add-apt-repository ppa:savoury1/multimedia -y
RUN add-apt-repository ppa:savoury1/ffmpeg4 -y
RUN add-apt-repository ppa:savoury1/ffmpeg-git -y
#RUN add-apt-repository ppa:graphics-drivers/ppa -y
RUN add-apt-repository ppa:git-core/ppa -y
RUN add-apt-repository ppa:brightbox/ruby-ng -y
RUN add-apt-repository ppa:chris-lea/redis-server -y
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
RUN apt-get dist-upgrade -yqq
RUN apt-get install -yqq git git-lfs ffmpeg telnet tree lshw
RUN ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime && dpkg-reconfigure -f noninteractive tzdata
RUN locale-gen id_ID && update-locale LANG=id_ID.UTF-8 LC_CTYPE=id_ID.UTF-8
RUN apt-get dist-upgrade -yqq
# RUN cd /tmp && curl -sS "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip -qq awscliv2.zip && sudo ./aws/install && aws --version
# RUN cd /usr/local/bin && wget -q -O dropbox https://www.dropbox.com/download?dl=packages/dropbox.py && chmod +x dropbox
# RUN cd ~ && wget -q -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
