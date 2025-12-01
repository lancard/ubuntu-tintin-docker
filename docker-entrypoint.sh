#!/bin/sh

term_handler() {
    kill -TERM "$child" 2>/dev/null || true
    exit 0
}

ln -sf /etc-account/passwd /etc/passwd
ln -sf /etc-account/shadow /etc/shadow
ln -sf /etc-account/group /etc/group
ln -sf /etc-account/gshadow /etc/gshadow

service cron start
service inetutils-inetd restart
service ssh start

echo love > /etc/hostname

tail -f /dev/null &
child=$!
wait "$child"
