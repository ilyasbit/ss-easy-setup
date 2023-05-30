#!/bin/bash

apt update -y
apt install -y tar screen wget curl git unzip --no-install-recommends

wget https://github.com/ilyasbit/ss-easy-setup/raw/main/ss.tar.gz -O /tmp/ss.tar.gz
tar -xvf /tmp/ss.tar.gz -C /tmp/
mv /tmp/ss/* /usr/local/bin/
