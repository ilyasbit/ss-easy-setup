#/bin/bash

file=$1

if [ ! -f "$file" ]; then
    echo "File not found!"
    exit 1
fi

local_ip=$(ip route get 8.8.8.8 | sed -nr 's/.*src ([^\ ]+).*/\1/p')
public_ip=$(curl -s ifconfig.me)

cat $file | while read line; do
    server_ip=$(echo $line | cut -d ":" -f1)
    port=$(echo $line | cut -d ":" -f2)
    screen -dmS sslocal_${port} sslocal -U -s $server_ip:8388 -k Pass -m aes-128-gcm -b "$local_ip:$port" --fast-open -v
    echo "running sslocal server $server_ip on port $port screen session : sslocal_${port}"
done
