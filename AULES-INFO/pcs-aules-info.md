1. ssh
    - copiar la clau publica
    - desactivar el password login
1. instalar client fog
1. instalar virtualbox
1. ubuntu-restricted-extras
    - bug:

          sudo apt remove gstreamer1.0-vaapi
      
1. vscode, intellij, chromium, vlc, gimp
1. iddigital
1. packettracer
1. Instalar SETTINGS
   
        sudo apt install gnome-control-center
   
1. Desinstalar:

        apt remove gnome-initial-setup update-notifier
 

1. BUG guardar-como firefox
   
        apt install xdg-desktop-portal xdg-desktop-portal-gtk
   
1. Instalar nmap, etccc

       sudo apt install nmap tree plocate

1. Node_18x
   
       curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
       bash nodesource_setup.sh
       apt install nodejs

1. apt install wireshark
2. Epoptes
    ```
    sudo sed -i 's/#WaylandEnable=false/WaylandEnable=false/g' /etc/gdm3/custom.conf
    sudo apt install -y epoptes-client ssvnc
    ```

## Docker
- canviar la red default `/etc/docker/daemon.json`

        {
           "bip": "10.0.100.1/24"
        }
  
- activar Rootless
  
      sudo setcap cap_net_bind_service=ep $(which rootlesskit)
  
      systemctl --user restart docker
    
    - Se te que afegir el usuari al fichero /etc/subuid i /etc/subgid
    
        - Instalar esto:
        ```
        apt install libpam-python
        ```
    
        - Afegir esta linea al fichero `/etc/pam.d/common-session`
        ```
        session required        pam_python.so /root/pam_slo.py
        ```
        - Script /root/pam_slo.py
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
- Cada alumne ha d'executar:

      dockerd-rootless-setuptool.sh install
      

      
    


# Server only

executar script `server_config.sh`

    bash -c "$(curl -fsSL https://raw.githubusercontent.com/benigaslo/docs/main/AULES-INFO/server_config.sh)"




