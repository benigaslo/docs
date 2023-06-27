1. ssh
    - copiar la clau publica
    - desactivar el password login
1. instalar client fog
1. instalar docker
    - falta mirar lo de posar als alumnes al grup docker -> no fa falta(pareix) nomes executar
      `dockerd-rootless-setuptool.sh install`
    - canviar la red default
1. instalar virtualbox
1. ubuntu-restricted-extras
    - bug: sudo apt remove gstreamer1.0-vaapi
1. vscode, intellij, chromium, vlc, gimp
1. iddigital
1. packettracer


## Server only
1. `apt install isc-dhcp-server`
    - copiar `dhcpd.conf`
1. netplan
    ```
    network:
      version: 2
      renderer: networkd
      ethernets:
        enp1s0:
          dhcp4: no
          addresses: [10.2.1.254/24]
        eno1:
          dhcp4: yes
    ```
1. `iptables -t nat -A POSTROUTING -o eno1 -j MASQUERADE`
