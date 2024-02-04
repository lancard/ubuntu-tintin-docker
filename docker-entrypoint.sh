#!/bin/bash

service cron start
service openbsd-inetd start

tail -f /dev/null
