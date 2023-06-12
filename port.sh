#!/bin/bash
## Configuracio dels portatils EducaEnDigital
PROVA=/

mkdir -p $PROVA/root/.ssh/
mkdir -p $PROVA/etc/netplan

if [ $PROVA != "/" ]
then
    cp /etc/hosts $PROVA/etc/hosts
    cp /etc/hostname $PROVA/etc/hostname
    cp /etc/netplan/01-network-manager-all.yaml $PROVA/etc/netplan/01-network-manager-all.yaml
fi

CARRO=$1
NUM=$2
while [[ -z $CARRO ]] 
do
    echo "CARRO:"
    read CARRO
done
while [[ -z $NUM ]] 
do
    echo "NUMERO PORTATIL:"
    read NUM
done

HOSTNAME="$CARRO-$NUM"
#echo $HOSTNAME

printf "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDbFrogzVkwI47O0OTvDGJYh8//GqiB6qe8QHOykBSzl7qrdQWHwxyJHoXfNEqY2lIez7FsXUm5NIJPDNktlGwSd3VoNkqXi+y++U/GBVgVu49KKhZ6PzFi7HRQiCO+/49IW5NsYdA+R2TWh/aYhVQ3yJktc4opG05wqJQJ5qxBiane53mWbmADiR37FyTj3UaqSKiupay46qH89D1SPigwQJYq/AwBHKdteGj110w0fOGnoHd9v24mtKtnXMB6/380ONH3gJEcMrC90KP+dKdpwWFu5R/xBp7EEynhyaMb35+vgBOOu9n0VhFA0k7ScdviheOHPlXHtfNfXTBAnZcrcXrX8q5E+berkFDPyBIdmkN2jumIfcyHCFM9Ks1sxLAIqWukWhjtk2M2xO8rpJnG3/l51BZMRyqUuDQUEBAHqG7uBV06jZ6ru/eBaqcnY5y5aBcdPtU+ufrzc4BgeIuvpjE3dVkPRrAqy+hEcHi+QF0tZu1YhiE6jdIonu/vXoU= root@bngsl-i7" > $PROVA/root/.ssh/authorized_keys
printf "networks:\n  version: 2\n  renderer: NetworkManager\n  wifis:\n    wlan0:\n      access-points:\n        \"WIFI_$CARRO\": {}\n      dhcp4: true" >  $PROVA/etc/netplan/01-network-manager-all.yaml 

cat $PROVA/etc/hostname  | grep -v "$HOSTNAME" > tmp && mv tmp $PROVA/etc/hostname
echo "$HOSTNAME" > $PROVA/etc/hostname

cat $PROVA/etc/hosts | grep -v administrador > tmp && mv tmp $PROVA/etc/hosts
cat $PROVA/etc/hosts | grep -v "127.0.1.1" > tmp && mv tmp $PROVA/etc/hosts
printf "127.0.1.1\t$HOSTNAME" >> $PROVA/etc/hosts 

netplan apply
