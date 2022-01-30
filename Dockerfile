FROM phusion/baseimage:master-amd64

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true

# Use baseimage-docker's init system.
CMD ["/bin/bash"]

# ...put your own build instructions here...
# COPY sources.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get dist-upgrade -yqq
RUN apt-get install -yqq apt-utils sudo
RUN apt-get install -yqq lsb-release apt-transport-https ca-certificates software-properties-common wget curl netcat aria2 whois figlet telnet tree lshw htop p7zip p7zip-full zip unzip
RUN apt-get install -yqq language-pack-gnome-en language-pack-gnome-id dirmngr gnupg gnupg2
RUN add-apt-repository ppa:savoury1/build-tools -y
RUN add-apt-repository ppa:savoury1/backports -y
RUN add-apt-repository ppa:savoury1/graphics -y
RUN add-apt-repository ppa:savoury1/multimedia -y
RUN add-apt-repository ppa:savoury1/ffmpeg4 -y
RUN add-apt-repository ppa:savoury1/ffmpeg-git -y
RUN add-apt-repository ppa:git-core/ppa -y
RUN add-apt-repository ppa:brightbox/ruby-ng -y
RUN add-apt-repository ppa:chris-lea/redis-server -y
RUN sudo add-apt-repository ppa:nginx/stable -y
RUN sudo add-apt-repository ppa:ondrej/php -y
RUN sudo add-apt-repository ppa:fish-shell/release-3 -y
RUN sudo add-apt-repository ppa:maxmind/ppa -y
RUN sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
    sudo add-apt-repository ppa:longsleep/golang-backports -y
RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
RUN sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger focal main > /etc/apt/sources.list.d/passenger.list'
RUN sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
RUN sudo sh -c 'echo deb http://apt.llvm.org/focal/ llvm-toolchain-focal main > /etc/apt/sources.list.d/llvm.list'
RUN sudo sh -c 'echo deb-src http://apt.llvm.org/focal/ llvm-toolchain-focal main >> /etc/apt/sources.list.d/llvm.list'
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
RUN curl -s https://install.speedtest.net/app/cli/install.deb.sh | sudo bash
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
RUN apt-get update && apt-get dist-upgrade -yqq
RUN sudo apt-get update && sudo apt-get install -yqq nodejs yarn git git-lfs gh speedtest golang
RUN apt-get install -yqq ffmpeg
RUN wget https://dl.min.io/client/mc/release/linux-amd64/mc -O /usr/local/bin/mc && chmod +x /usr/local/bin/mc
RUN cd /tmp && wget https://github.com/gohugoio/hugo/releases/download/v0.92.1/hugo_extended_0.92.1_Linux-64bit.deb && apt install ./*.deb
RUN ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime && dpkg-reconfigure -f noninteractive tzdata
RUN locale-gen id_ID && update-locale LANG=id_ID.UTF-8 LC_CTYPE=id_ID.UTF-8
RUN apt-get dist-upgrade -yqq
# RUN cat /etc/apt/sources.list | curl -F 'clbin=<-' https://clbin.com
# RUN cd /tmp && curl -sS "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip -qq awscliv2.zip && sudo ./aws/install && aws --version
# RUN cd /usr/local/bin && wget -q -O dropbox https://www.dropbox.com/download?dl=packages/dropbox.py && chmod +x dropbox
# RUN cd ~ && wget -q -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
