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
1. SETTINGS (QUE HA PASSAT??)
    - `apt install gnome-control-center`
1. `apt remove gnome-initial-setup update-notifier`
 

1. BUG guardar-como firefox
    - `apt install xdg-desktop-portal xdg-desktop-portal-gtk`
1. `apt install nmap`
1. Node_18x
   `curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh`
   `bash nodesource_setup.sh`
   `apt install nodejs`

1. apt install wireshark

## Server only
1. `apt install dnsmasq`
    - copiar `dnsmasq.conf`
1. netplan
    ```
    network:
      version: 2
      renderer: NetworkManager
      ethernets:
        enp1s0:
          dhcp4: no
          addresses: [10.2.1.254/24]
        eno1:
          dhcp4: yes
    ```
1. iptables
    - ip_forward
        -  `printf "net.ipv4.ip_forward = 1" >> /etc/systctl.conf`
    - `apt install iptables-persistent`
    - nat
        `iptables -t nat -A POSTROUTING -o eno1 -j MASQUERADE`
        `iptables -P FORWARD ACCEPT`
    - TFTP through nat
        - `printf "nf_nat_tftp" >> /etc/modules-load.d/modules.conf`
        - `iptables -t raw -I PREROUTING -j CT -p udp -m udp --dport 69 --helper tftp`
    - Guardar les regles:
        `iptables-save > /etc/iptables/rules.v4`
