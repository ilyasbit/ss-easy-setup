#!/bin/bash

apt update -y
apt install -y tar screen wget curl nano htop --no-install-recommends

wget https://github.com/ilyasbit/ss-easy-setup/raw/main/ss.tar.gz -O /tmp/ss.tar.gz
tar -xvf /tmp/ss.tar.gz -C /tmp/
mv /tmp/ss/* /usr/local/bin/

local_ip=$(ip route get 8.8.8.8 | sed -nr 's/.*src ([^\ ]+).*/\1/p')
public_ip=$(curl -s fake.chiacloud.farm/ip)

mkdir /etc/shadowsocks
cat >/etc/shadowsocks/config.json <<EOF
{
    "server":"$local_ip",
    "server_port": 8388,
    "password": "Pass",
    "mode": "tcp_and_udp",
    "local_address": "$local_ip",
    "local_port": 1081,
    "local_udp_address": "$local_ip",
    "local_udp_port": 2081,
    "timeout": 7200,
    "reuse_port": true,
    "method": "aes-128-gcm",
    "fast_open": true,
    "log": {
        "level": 1
    },
    "runtime": {
        "mode": "multi_thread",
        "worker_count": 10
    }
}
EOF

cat >/etc/systemd/system/shadowsocks.service <<EOF
[Unit]
Description=shadowsocks server
Wants=network-online.target
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/ssserver -c /etc/shadowsocks/config.json
User=root

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable shadowsocks
systemctl start shadowsocks
