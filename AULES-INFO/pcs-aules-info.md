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

## Docker rootless
Se te que afegir el usuari al fichero /etc/subuid i /etc/subgid

Se podria fer en un modul pam, que l'afegisca quan se inicie la sessio

Instalar esto:
```
install libpam-python
```

Afegir esta linea al fichero `/etc/pam.d/common-session`
```
session required        pam_python.so /root/pam_slo.py
```

/root/pam_slo.py
```
def pam_sm_open_session(pamh, flags, argv):
  user=pamh.get_user(None)
  require_line("/etc/subuid", "%s:100000:65536\n" % user)
  require_line("/etc/subgid", "%s:100000:65536\n" % user)
  return pamh.PAM_SUCCESS

def require_line(file_path, word):
  found=False
  with open(file_path, "r") as file:
    content = file.read()
    if word in content:
      found=True

  if not found:
    with open(file_path, 'a') as file:
      file.write(word)
```


# Server only

executar script `server_config.sh`

`bash -c "$(curl -fsSL https://raw.githubusercontent.com/benigaslo/docs/main/AULES-INFO/server_config.sh)"`


## Drivers realtek
El driver r8169 (in-kernel) falla, s'ha d'instal·lar el r8168:
```
apt install r8168-dkms
printf "blacklist r8169" > /etc/modprobe.d/blacklist.conf
update-initramfs -u 
```



