## TODO:

1. Instalar gcc ¿? (per lo de /sbin/vbox...)
1. Canviar Java11 per Java 22
1. Falta mirar lo del proxy automatic autodiscover

1. instalar virtualbox, intellij, packettracer

1. Canviar en el server, posar accediu amb pro/pro 

1. Epoptes
   - Server

         sudo sed -i 's/#WaylandEnable=false/WaylandEnable=false/g' /etc/gdm3/custom.conf
         sudo apt install -y epoptes ssvnc
         sudo adduser pro epoptes
     
    - Client

          sudo sed -i 's/#WaylandEnable=false/WaylandEnable=false/g' /etc/gdm3/custom.conf
          sudo apt install -y epoptes-client ssvnc
          sudo epoptes-client -c
   

## lib-pam python 

Ja no fa falta, se utilitzava per a afegir als usuaris al subuid i subgid al logejar-se (per el docker), pero ara se fa per el /etc/security/group.conf
 
        - Instalar esto:
        ```
        sudo apt install libpam-python
        ```
    
        - Afegir esta linea al fichero `/etc/pam.d/common-session`
        ```
        session required        pam_python.so /root/pam_slo.py
        ```
        
        - Script /root/pam_slo.py
        
        ```
        def pam_sm_open_session(pamh, flags, argv):
          user=pamh.get_user(None)
          # fer lo que se desitje quan se logueje l'usuari
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

    bash -c "$(curl -fsSL https://raw.githubusercontent.com/benigaslo/docs/main/AULES-INFO/server_config.sh)"




