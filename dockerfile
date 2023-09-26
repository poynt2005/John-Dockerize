FROM alpine AS builder

RUN apk add wget build-base perl openssl-dev linux-headers qt5-qtbase-dev

RUN wget https://github.com/openwall/john/archive/bleeding-jumbo.tar.gz -O src.tar.gz \
    && tar -zxvf src.tar.gz

RUN cd john-bleeding-jumbo/src \
    && ./configure \
    && make -j$(nproc) \ 
    && make install 

RUN wget https://github.com/openwall/johnny/archive/refs/tags/v2.2.tar.gz  -O 2.2.tar.gz \
    && tar -zxvf 2.2.tar.gz

ARG QT_SELECT=qt5

RUN cd johnny-2.2/src \
    && qmake -makefile ../johnny.pro && make -j$(nproc)

FROM jlesage/baseimage-gui:alpine-3.18-v4

ENV APP_NAME="JohnnyTheRipper Gui Interface"
ENV NOVNC_LANGUAGE="zh_Hant"
ENV TZ=Asia/Taipei
ENV HOME=/config
ENV USER_ID=0
ENV GROUP_ID=0
ENV KEEP_APP_RUNNING=1

RUN apk add  --no-cache libgomp qt5-qtbase-x11 msttcorefonts-installer fontconfig
RUN update-ms-fonts && fc-cache -f

WORKDIR /app
COPY --from=builder /john-bleeding-jumbo/run/john ./john
COPY --from=builder /johnny-2.2/src/johnny ./johnny

RUN ln -sf /app/johnny /usr/bin/johnny
RUN ln -sf /app/john /usr/bin/john

COPY startapp.sh /startapp.sh 
RUN chmod +x /startapp.sh 