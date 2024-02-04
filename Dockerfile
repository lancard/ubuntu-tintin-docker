FROM ubuntu

RUN ulimit -c unlimited
RUN apt-get update
RUN apt-get install locales gcc make lrzsz telnetd libreadline-dev net-tools vim telnet ftp file screen wget git -y
RUN apt-get upgrade -y
RUN localedef -i ko_KR -c -f UTF-8 -A /usr/share/locale/locale.alias ko_KR.UTF-8
ENV LANG ko_KR.UTF-8


WORKDIR /root
RUN git clone https://github.com/lancard/tintin.git
WORKDIR /root/tintin/src
RUN ./configure
RUN make
RUN cp tt++ /bin/tt

WORKDIR /root
RUN wget https://github.com/prasmussen/gdrive/releases/download/2.1.1/gdrive_2.1.1_linux_386.tar.gz
RUN tar xvzf gdrive_2.1.1_linux_386.tar.gz
RUN cp gdrive /sbin

COPY --chmod=755 docker-entrypoint.sh /

ENTRYPOINT /docker-entrypoint.sh
