#!/bin/bash

service nordvpn start

nordvpn login -u $USERNAME -p "$PASSWORD"
nordvpn set technology nordlynx
nordvpn connect

tail -f /dev/null