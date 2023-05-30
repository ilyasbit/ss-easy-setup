# Shadowsocks Easy Install

Requirement :

- Ubuntu 20.04 LTS 64 BIT
- Open All Port

# How to Install

## Install on VPS as SSSERVER

    sudo curl https://github.com/ilyasbit/ss-easy-setup/raw/main/install-server.sh | sudo bash -s

## Install on VPS as Router host multiple SSLOCAL

    sudo curl https://github.com/ilyasbit/ss-easy-setup/raw/main/install-only.sh | sudo bash -s

## Run Multiple sslocal on Router

- save all ssserver ip address and desire port for host sslocal in a text file
  example server-list.txt :

      12.23.35.45:1080
      12.23.36.46:1081
      12.23.37.47:1082
      12.23.38.48:1083
      12.23.39.49:1084

- run this command, change the text-file.txt with your file

  sudo curl https://github.com/ilyasbit/ss-easy-setup/raw/main/install-only.sh | sudo bash -s -- text-file.txt
