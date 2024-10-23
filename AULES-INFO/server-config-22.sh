#!/usr/bin/bash

ip -br -c a

INTER_IFACE=$1
LOCAL_IFACE=$2
HOSTNAME=$3

while [[ -z $INTER_IFACE ]] 
do
    echo "Interface d'internet:"
    read INTER_IFACE
done

while [[ -z $LOCAL_IFACE ]] 
do
    echo "Interface local:"
    read LOCAL_IFACE
done

#while [[ -z $HOSTNAME ]] 
#do
#    echo "Hostname:"
#    read HOSTNAME
#done

######## CONFIG DNSMASQ

apt install dnsmasq

cat << EOF > /etc/dnsmasq.conf
bind-interfaces
domain-needed
bogus-priv
strict-order
expand-hosts
no-hosts
server=10.239.3.7
server=10.239.3.8

interface=$LOCAL_IFACE
dhcp-authoritative
dhcp-ignore-names
dhcp-option=option:router,0.0.0.0
dhcp-option=option:dns-server,10.2.1.254
dhcp-range=10.2.1.100,10.2.1.199,12h

tftp-root=/tftpboot
dhcp-boot=undionly.kpxe,,172.21.44.254
dhcp-no-override
dhcp-vendorclass=BIOS,PXEClient:Arch:00000
dhcp-vendorclass=UEFI32,PXEClient:Arch:00006
dhcp-vendorclass=UEFI,PXEClient:Arch:00007
dhcp-vendorclass=UEFI64,PXEClient:Arch:00009
dhcp-boot=net:UEFI32,i386-efi/ipxe.efi,,172.21.44.254
dhcp-boot=net:UEFI,ipxe.efi,,172.21.44.254
dhcp-boot=net:UEFI64,ipxe.efi,,172.21.44.254
pxe-prompt="Booting FOG Client", 1
pxe-service=X86PC, "Boot to FOG", undionly.kpxe,172.21.44.254
pxe-service=X86-64_EFI, "Boot to FOG UEFI", ipxe.efi,172.21.44.254
pxe-service=BC_EFI, "Boot to FOG UEFI PXE-BC", ipxe.efi,172.21.44.254

conf-dir=/etc/dnsmasq.d/
EOF

# Esperar a que la xarxa estiga online per a iniciar dnsmasq

cat << EOF > /lib/systemd/system/dnsmasq.service
[Unit]
Description=dnsmasq - A lightweight DHCP and caching DNS server
Requires=network-online.target
Wants=nss-lookup.target
Before=nss-lookup.target
After=network-online.target

[Service]
Type=forking
PIDFile=/run/dnsmasq/dnsmasq.pid
ExecStartPre=/etc/init.d/dnsmasq checkconfig
ExecStart=/etc/init.d/dnsmasq systemd-exec
ExecStartPost=/etc/init.d/dnsmasq systemd-start-resolvconf
ExecStop=/etc/init.d/dnsmasq systemd-stop-resolvconf
ExecReload=/bin/kill -HUP $MAINPID
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

############## CONFIG NETPLAN

cat << EOF > /etc/netplan/01-network-manager-all.yaml
network:
  version: 2
  renderer: NetworkManager
  ethernets:
    $LOCAL_IFACE:
      dhcp4: no
      addresses: [10.2.1.254/24]
    $INTER_IFACE:
      dhcp4: yes
EOF

netplan apply
sleep 10
systemctl daemon-reload
systemctl restart dnsmasq

############# CONFIG ROUTER

sed -i "/ip_forward/d" /etc/sysctl.conf
printf "net.ipv4.ip_forward = 1" >> /etc/systctl.conf

iptables -t nat -A POSTROUTING -o $INTER_IFACE -j MASQUERADE
iptables -A FORWARD -j ACCEPT

# NATejar el TFTP
modprobe nf_nat_tftp
printf "nf_nat_tftp" >> /etc/modules-load.d/nf_nat_tftp.conf
iptables -t raw -I PREROUTING -j CT -p udp -m udp --dport 69 --helper tftp

apt install iptables-persistent
iptables-save > /etc/iptables/rules.v4

# Drivers realtek
apt install -y r8168-dkms
#sed -i "/blacklist r8169/d" /etc/modprobe.d/blacklist.conf
#printf "blacklist r8169\n" >> /etc/modprobe.d/blacklist.conf
printf "blacklist r8169\n" > /etc/modprobe.d/blacklist_r8169.conf

update-initramfs -u 

# ================
# Capaor
# ================

curl -fsSLo /usr/local/sbin/capaor https://raw.githubusercontent.com/benigaslo/bin/refs/heads/main/capaor.sh
chmod +x /usr/local/sbin/capaor
