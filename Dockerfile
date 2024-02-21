# https://github.com/zhlii/wine
FROM registry.cn-hangzhou.aliyuncs.com/xduo/wine:1.0.0

#deps
RUN set -eux;

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list; \    
    apt-get update --allow-unauthenticated --allow-insecure-repositories;

RUN apt-get install -y \
    git net-tools curl wget supervisor fluxbox \
    x11vnc novnc xvfb xdotool \
    gnupg2 software-properties-common

RUN apt-get install -y ttf-wqy-microhei locales procps \
    && rm -rf /var/lib/apt/lists/* \
    && sed -ie 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/g' /etc/locale.gen \
    && locale-gen

ENV DISPLAY_WIDTH=1280 \
    DISPLAY_HEIGHT=720 \
    DISPLAY=:0.0 \
    LANG=zh_CN.UTF-8 \
    LANGUAGE=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8 \
    WINEPREFIX=/root/.wine

COPY root/ /
RUN mv /index.html /usr/share/novnc/
RUN mkdir ~/.vnc

EXPOSE 8080

WORKDIR /root

RUN bash -c 'nohup /entrypoint.sh 2>&1 &' && sleep 6 && /init.sh && rm /tmp/.X0-lock

ENTRYPOINT ["/entrypoint.sh"]
