# Desactivar actualitzacions automatiques snap
snap refresh --hold

apt remove gstreamer1.0-vaapi gnome-initial-setup update-notifier
apt install gnome-control-center xdg-desktop-portal xdg-desktop-portal-gtk nmap tree plocate wget curl
# instalar virtualbox, vscode, intellij, chromium, vlc, gimp, dia, kdenlive, audacity, packettracer wireshark

curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
bash nodesource_setup.sh
apt install nodejs



# Copiar la clau publica
mkdir -p /root/.ssh/
curl https://raw.githubusercontent.com/benigaslo/docs/main/id_rsa.pub > /root/.ssh/authorized_keys

# Desactivar el ssh password login
sed -i 's/.*PasswordAuthentication.*/PasswordAuthentication no/g' /etc/ssh/sshd_config

# Configurar la red default docker
mkdir -p /etc/docker/
cat << EOF > /etc/docker/daemon.json
  {
     "bip": "10.0.100.1/24"
  }
EOF

# Activar docker rootless
sudo setcap cap_net_bind_service=ep $(which rootlesskit)
systemctl --user restart docker
