#!/usr/bin/env bash
set -ex

x11vnc -storepasswd ${VNC_PASSWORD:-vncpass} ~/.vnc/passwd

bash -c 'supervisord -c /etc/supervisord.conf -l /var/log/supervisord.log'