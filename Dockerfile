FROM ubuntu

WORKDIR /root

RUN ulimit -c unlimited
RUN apt-get update
RUN apt-get install locales gcc make lrzsz telnetd libreadline-dev net-tools vim telnet ftp file screen wget git -y
RUN apt-get upgrade -y

RUN git clone https://github.com/lancard/tintin.git
WORKDIR /root/tintin/src
RUN ./configure
RUN make
RUN cp tt++ /bin/tt

RUN wget https://github.com/prasmussen/gdrive/releases/download/2.1.1/gdrive_2.1.1_linux_386.tar.gz
RUN tar xvzf gdrive_2.1.1_linux_386.tar.gz
RUN cp gdrive /sbin

ENTRYPOINT ["/usr/bin/tail", "-f", "/dev/null"]
