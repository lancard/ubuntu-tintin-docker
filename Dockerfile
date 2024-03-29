FROM ubuntu

RUN ulimit -c unlimited
RUN apt-get update
RUN apt-get install locales gcc make lrzsz telnetd libreadline-dev net-tools vim telnet ftp file screen wget git cron ssh -y
RUN apt-get upgrade -y
RUN localedef -i ko_KR -c -f UTF-8 -A /usr/share/locale/locale.alias ko_KR.EUC-KR
ENV LANG ko_KR.EUC-KR
RUN update-locale LANG=ko_KR.EUC-KR
RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

RUN echo "net.ipv6.conf.all.disable_ipv6=1" >> /etc/sysctl.conf
RUN echo "net.ipv6.conf.default.disable_ipv6=1" >> /etc/sysctl.conf
RUN echo "net.ipv6.conf.lo.disable_ipv6=1" >> /etc/sysctl.conf
RUN echo "net.ipv4.tcp_low_latency=1" >> /etc/sysctl.conf

WORKDIR /root
RUN echo "0 1 * * * tar czf ~/love.tar.gz /home /etc" > crontab.txt
RUN echo "0 2 * * * apt-get update && apt-get upgrade -y" >> crontab.txt
RUN cat crontab.txt | crontab -

WORKDIR /root
RUN git clone https://github.com/lancard/tintin.git
WORKDIR /root/tintin/src
RUN ./configure
RUN make
RUN cp tt++ /bin/tt

WORKDIR /
COPY --chmod=755 docker-entrypoint.sh /

ENTRYPOINT /docker-entrypoint.sh
