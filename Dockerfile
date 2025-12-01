FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN ulimit -c unlimited

RUN apt-get update
RUN apt-get install -y locales gcc make lrzsz telnetd libreadline-dev net-tools vim telnet ftp file screen wget git cron ssh tini
RUN apt-get upgrade -y

ENV TZ=Asia/Seoul
ENV LANG=ko_KR.EUC-KR
ENV LANGUAGE=ko_KR:ko
ENV LC_ALL=ko_KR.EUC-KR
RUN sed -i 's/^# ko_KR.EUC-KR EUC-KR/ko_KR.EUC-KR EUC-KR/' /etc/locale.gen && locale-gen $LANG && update-locale LANG=$LANG
RUN localedef -i ko_KR -c -f UTF-8 -A /usr/share/locale/locale.alias ko_KR.EUC-KR
RUN update-locale LANG=ko_KR.EUC-KR
RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

RUN echo "net.ipv6.conf.all.disable_ipv6=1" >> /etc/sysctl.conf
RUN echo "net.ipv6.conf.default.disable_ipv6=1" >> /etc/sysctl.conf
RUN echo "net.ipv6.conf.lo.disable_ipv6=1" >> /etc/sysctl.conf
RUN echo "net.ipv4.tcp_low_latency=1" >> /etc/sysctl.conf

RUN sed -i 's/^#<off>#\s*telnet/telnet/' /etc/inetd.conf

WORKDIR /root
RUN echo "0 1 * * * tar czf ~/love.tar.gz /home /etc" > crontab.txt
RUN echo "0 2 * * * apt-get update && apt-get upgrade -y" >> crontab.txt
RUN echo "0 3 1 * * kill 1" >> crontab.txt
RUN cat crontab.txt | crontab -

WORKDIR /root
RUN git clone https://github.com/lancard/tintin.git
WORKDIR /root/tintin/src
RUN ./configure
RUN make
RUN cp tt++ /bin/tt

WORKDIR /
COPY --chmod=755 entrypoint.sh /

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/entrypoint.sh"]
