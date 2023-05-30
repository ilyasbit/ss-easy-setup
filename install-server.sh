#!/bin/bash

apt update -y
apt install -y tar screen wget curl git unzip --no-install-recommends

wget https://github.com/ilyasbit/ss-easy-setup/raw/main/ss.tar.gz -O /tmp/ss.tar.gz
tar -xvf /tmp/ss.tar.gz -C /tmp/
mv /tmp/ss/* /usr/local/bin/

local_ip=$(ip route get 8.8.8.8 | sed -nr 's/.*src ([^\ ]+).*/\1/p')
public_ip=$(curl -s ifconfig.me)

screen -dmS ssserver ssserver -U -s $local_ip:8388 -k Pass -m aes-128-gcm --worker-threads 10 --tcp-fast-open -v
