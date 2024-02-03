FROM ubuntu

WORKDIR /root

RUN ulimit -c unlimited
RUN apt-get update
RUN apt-get install locales gcc make lrzsz telnetd libreadline-dev net-tools vim telnet ftp file screen wget -y
RUN apt-get upgrade -y

RUN wget https://github.com/lancard/tintin/raw/master/tintin%2B%2Bv1.86.tar.gz
RUN tar xvzf tintin++v1.86.tar.gz
WORKDIR /root/tintin++/src
RUN ./configure
RUN make

RUN cp tt++ /bin/tt

WORKDIR /root/tintin++

RUN ./configure
RUN make

RUN wget https://github.com/prasmussen/gdrive/releases/download/2.1.1/gdrive_2.1.1_linux_386.tar.gz
RUN tar xvzf gdrive_2.1.1_linux_386.tar.gz
RUN cp gdrive /sbin

ENTRYPOINT ["/usr/bin/tail", "-f", "/dev/null"]
