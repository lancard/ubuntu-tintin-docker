#!/bin/bash

service cron start
service openbsd-inetd start
service ssh start

echo love > /etc/hostname

tail -f /dev/null
