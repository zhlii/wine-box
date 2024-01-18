#!/usr/bin/env bash
set -ex

bash -c 'supervisord -c /etc/supervisord.conf -l /var/log/supervisord.log'
