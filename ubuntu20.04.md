# Ubuntu 20.04 als ordinadors de aules de la ESO, Sala de profes, etc.

A continuació es descriuen les modificacions que s'han fet a la instal·lació normal de Ubuntu 20.04

## Instal·lar clickControl

```
wget https://github.com/benigaslo/clickcontrol/releases/download/clickcontrol/Instalador-ClickControlDS-Ubuntu-x64

chmod +x Instalador-ClickControlDS-Ubuntu-x64

sudo ./Instalador-ClickControlDS-Ubuntu-x64
```

## desinstal·lar gnome-initial-setup

Eliminar lo de setup accounts, livepatch, ...

```
apt remove gnome-initial-setup
```

## canviar les aplicacions favorites (barra de tareas / dash)

Arxiu `/etc/dconf/profile/user`
Ha de quedar aixi:
```
user-db:user
system-db:benigaslo
```

Arxiu `/etc/dconf/db/benigaslo.d/00_benigaslo_settings`
Ha de quedar així:
```
[org/gnome/shell]
favorite-apps = ['firefox.desktop', 'nautilus.desktop']
```

Després executar:
```
dconf update; chmod a+rx -R /etc/dconf
```

## Desativar la finestra de actualitzcions

......

## Permetre l'accés per ssh amb clau-pública
```
sudo apt install openssh-server
```
Deshabilitar l'accés amb password
```
echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config
```

Copiar la clau pública
```
sudo sh -c 'curl -fsSL  https://github.com/benigaslo/docs/releases/download/id_rsa/id_rsa.pub >> /root/.ssh/authorized_keys'

