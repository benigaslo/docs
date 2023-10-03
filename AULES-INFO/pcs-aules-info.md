1. ssh
    - copiar la clau publica
    - desactivar el password login
1. instalar client fog
1. instalar docker
    - falta mirar lo de posar als alumnes al grup docker -> no fa falta(pareix) nomes executar
      
      `dockerd-rootless-setuptool.sh install`
      
      `sudo setcap cap_net_bind_service=ep $(which rootlesskit)`

      `systemctl --user restart docker`
      
    - canviar la red default `/etc/docker/daemon.json`
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

executar script `server_config.sh`
`bash -c "$(curl -fsSL https://raw.githubusercontent.com/benigaslo/docs/main/AULES-INFO/server_config.sh)"`


# Drivers realtek
El driver r8169 (in-kernel) falla, s'ha d'instal·lar el r8168:
```
apt install r8168-dkms
printf "blacklist r8169" > /etc/modprobe.d/blacklist.conf
update-initramfs -u 
```

