#!/bin/bash

service cron start
service openbsd-inetd start
service ssh start

echo love > /etc/hostname

echo "need to EUC-KR for dpkg-reconfigure locales"

tail -f /dev/null
