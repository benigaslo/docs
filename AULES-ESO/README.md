# Ubuntu 20.04 als ordinadors de aules de la ESO, Batx, Sala de profes, etc.

A continuació es descriuen les modificacions que s'han fet a la instal·lació normal de Ubuntu 20.04

## Instal·lar utils
```
apt install curl
```

## Instal·lar clickControl

```
wget https://github.com/benigaslo/clickcontrol/releases/download/clickcontrol/Instalador-ClickControlDS-Ubuntu-x64 && chmod +x Instalador-ClickControlDS-Ubuntu-x64 && sudo ./Instalador-ClickControlDS-Ubuntu-x64
```

## desinstal·lar gnome-initial-setup

Eliminar lo de setup accounts, livepatch, ...

```
apt remove gnome-initial-setup
```

## canviar les aplicacions favorites (barra de tareas / dash)

Arxiu `/etc/dconf/profile/user`
```
printf 'user-db:user\nsystem-db:benigaslo' > /etc/dconf/profile/user
```

Arxiu `/etc/dconf/db/benigaslo.d/00_benigaslo_settings`
```
mkdir -p /etc/dconf/db/benigaslo.d/ && printf "[org/gnome/shell]\nfavorite-apps = ['firefox.desktop', 'nautilus.desktop']" > /etc/dconf/db/benigaslo.d/00_benigaslo_settings
```

Després executar:
```
dconf update; chmod a+rx -R /etc/dconf
```

## Desactivar la finestra d'actualitzcions

```
apt remove update-notifier
```

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
mkdir -p /root/.ssh && sh -c 'curl -fsSL  https://github.com/benigaslo/docs/releases/download/id_rsa/id_rsa.pub >> /root/.ssh/authorized_keys'
```

## Amagar la llista d'usuaris

```
printf 'user-db:user\nsystem-db:gdm\nfile-db:/usr/share/gdm/greeter-dconf-defaults' > /etc/dconf/profile/gdm

mkdir -p /etc/dconf/db/gdm.d/ && printf '[org/gnome/login-screen]\ndisable-user-list=true' > /etc/dconf/db/gdm.d/00-login-screen

dconf update; chmod a+rx -R /etc/dconf
```

## Deshabilitar el "canviar usuari"

```
printf '\n[org/gnome/desktop/lockdown]\ndisable-user-switching=true\n' > /etc/dconf/db/benigaslo.d/00_benigaslo_settings

dconf update
```

## Deshabilitar bloqueig (suspender)
```
gsettings set org.gnome.desktop.lockdown disable-lock-screen true
```
