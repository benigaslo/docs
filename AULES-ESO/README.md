# Ubuntu 20.04 als ordinadors de aules de la ESO, Batx, Sala de profes, etc.

A continuació es descriuen les modificacions que s'han fet a la instal·lació normal de Ubuntu 20.04


## Executar script ubuntu2004-aules-eso-config.sh


## Instal·lar clickControl

```
wget https://github.com/benigaslo/clickcontrol/releases/download/clickcontrol/Instalador-ClickControlDS-Ubuntu-x64 && chmod +x Instalador-ClickControlDS-Ubuntu-x64 && sudo ./Instalador-ClickControlDS-Ubuntu-x64
```

server ip: 192.168.1.250

tot default

Configuracion de PAM: tot menos el fingerprint


## Instal·lar client FOG



## Llevar POP session
```
rm /usr/share/xsessions/pop.desktop
```
