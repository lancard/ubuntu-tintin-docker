#!/bin/bash

service cron start
service openbsd-inetd start
service ssh start

tail -f /dev/null
