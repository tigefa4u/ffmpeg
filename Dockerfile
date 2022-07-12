FROM alpine:edge

RUN apk add --upgrade --no-cache ffmpeg aria2 wget curl bash git rclone \
    && wget --quiet https://dl.min.io/client/mc/release/linux-amd64/mc -O /usr/bin/mc && chmod +x /usr/bin/mc \
    && apk add --upgrade --no-cache --repository https://alpine.global.ssl.fastly.net/alpine/edge/main py3-pip bash-completion \
    && pip --no-cache-dir install s3cmd \
    && apk -U upgrade \
    && rm -rf /root/.cache /root/.config /tmp/* /var/tmp/*

CMD ["/bin/bash"]
