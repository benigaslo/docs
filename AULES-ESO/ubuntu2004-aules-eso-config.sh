apt update
apt install -y curl openssh-server
apt remove gnome-initial-setup update-notifier

#
# canviar aplicacions favorites
# deshabilitar canviar d'usuari
# deshabilitar bloqueig de pantalla
#
cat << EOF > /etc/dconf/profile/user
user-db:user\nsystem-db:benigaslo'
EOF

mkdir -p /etc/dconf/db/benigaslo.d/ 

cat << EOF > /etc/dconf/db/benigaslo.d/00_benigaslo_settings
[org/gnome/shell]
favorite-apps = ['firefox.desktop', 'nautilus.desktop'] 

[org/gnome/desktop/lockdown]
disable-user-switching=true
disable-lock-screen=true
EOF

#
# amagar la llista de usuaris a la pantalla de login
#
cat << EOF > /etc/dconf/profile/gdm
user-db:user
system-db:gdm
file-db:/usr/share/gdm/greeter-dconf-defaults
EOF

mkdir -p /etc/dconf/db/gdm.d/ 

cat << EOF > /etc/dconf/db/gdm.d/00-login-screen
[org/gnome/login-screen]
disable-user-list=true
EOF

dconf update 
chmod a+rx -R /etc/dconf

#
# Deshabilitar la hibernacio
#
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

#
# configurar ssh
#
echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config
mkdir -p /root/.ssh 
sh -c 'curl -fsSL  https://github.com/benigaslo/docs/releases/download/id_rsa/id_rsa.pub > /root/.ssh/authorized_keys'

# instalar clickcontrol
# wget https://github.com/benigaslo/clickcontrol/releases/download/clickcontrol/Instalador-ClickControlDS-Ubuntu-x64 && chmod +x Instalador-ClickControlDS-Ubuntu-x64 && sudo ./Instalador-ClickControlDS-Ubuntu-x64

