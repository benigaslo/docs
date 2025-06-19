# =================
# Drivers realtek
# =================
apt install -y r8168-dkms
# sed -i "/blacklist r8169/d" /etc/modprobe.d/blacklist.conf
printf "blacklist r8169\n" > /etc/modprobe.d/blacklist_r8169.conf
update-initramfs -u 



# ==========================================
# Per a que els clients arranquen del fog
# ==========================================

# eliminar fichero /etc/dnsqmasq.d/llxbootmanager.conf
rm /etc/dnsmasq.d/llxbootmanager.conf

# Afegir este
cat << EOF > /etc/dnsmasq.d/fog-boot.conf
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
EOF

# NATejar el TFTP
modprobe nf_nat_tftp
printf "nf_nat_tftp" > /etc/modules-load.d/nf_nat_tftp.conf
iptables -t raw -I PREROUTING -j CT -p udp -m udp --dport 69 --helper tftp

apt install iptables-persistent
iptables-save > /etc/iptables/rules.v4
