#!/bin/bash

ln -sf /etc-account/passwd /etc/passwd
ln -sf /etc-account/shadow /etc/shadow
ln -sf /etc-account/group /etc/group
ln -sf /etc-account/gshadow /etc/gshadow

service cron start
service openbsd-inetd start
service ssh start

echo love > /etc/hostname

tail -f /dev/null
