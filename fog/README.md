# FOG

Actualment, el dhcp-boot el fa el router de ClickControl. El dnsmasq del server esta deshabilitat.
¿? EN el dhcp-boot del CC està configurat l'arxiu `undionly.kkpxe`

Per a arrancar maquines virtuals QEMU/KVM en mode UEFI (TianoCore amb Secure Boot deshabilitat) s'ha de reanomenar l'arxiu `/tftpboot/snponly.efi` a `/tftpboot/undionly.kkpxe`

Per a arrancar ordinadors normals i vms BIOS s'ha de reanomenar l'arxiu  `/tftpboot/undionly.kkpxe.decine` a `/tftpboot/undionly.kkpxe`

L'arxiu `/tftpboot/undionly.kkpxe.decine` es una copia de seguretat de `/tftpboot/undionly.kkpxe`

## dnsmasq
Actualment:
* Esta deshabilitat
* El fitxer /etc/dnsmasq.conf esta tot comentat
* El fitxer /etc/dnsmasq.d/dhcp-proxy si que esta
