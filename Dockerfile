FROM ghcr.io/phusion/baseimage:noble-1.0.0

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true

# ...put your own build instructions here...
# COPY sources.list /etc/apt/sources.list
RUN apt-get update \
    && apt-get dist-upgrade -yqq \
    && apt-get install -yqq apt-utils sudo \
    && apt-get install -yqq lsb-release apt-transport-https ca-certificates software-properties-common bash bash-completion wget curl shellcheck htop aria2 tar rar unrar p7zip p7zip-full zip unzip \
    && add-apt-repository ppa:git-core/ppa -y \
    && add-apt-repository ppa:redislabs/redis -y \
    && add-apt-repository ppa:ondrej/nginx-mainline -y \
    && add-apt-repository ppa:ondrej/php -y \
    && add-apt-repository ppa:maxmind/ppa -y \
    && curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash \
    && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get update && apt-get dist-upgrade -yqq \
    && apt-get install -yqq git git-lfs \
    && apt-get install -yqq ffmpeg \
    && wget --quiet https://dl.min.io/client/mc/release/linux-amd64/mc -O /usr/local/bin/mc && chmod +x /usr/local/bin/mc \
    && apt-get install -yqq s3cmd \
    && apt-get install -yqq tzdata \
    && ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Use baseimage-docker's init system.
CMD ["/bin/bash"]
