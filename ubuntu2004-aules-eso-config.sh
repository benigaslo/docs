apt update
apt install -y curl openjdk-8-jre-headless openssh-server
apt remove gnome-initial-setup update-notifier

# canviar aplicacions favorites
printf 'user-db:user\nsystem-db:benigaslo' > /etc/dconf/profile/user
mkdir -p /etc/dconf/db/benigaslo.d/ && printf "[org/gnome/shell]\nfavorite-apps = ['firefox.desktop', 'nautilus.desktop']" > /etc/dconf/db/benigaslo.d/00_benigaslo_settings

# amagar la llista de usuaris a la pantalla de login
printf 'user-db:user\nsystem-db:gdm\nfile-db:/usr/share/gdm/greeter-dconf-defaults' > /etc/dconf/profile/gdm
mkdir -p /etc/dconf/db/gdm.d/ && printf '[org/gnome/login-screen]\ndisable-user-list=true' > /etc/dconf/db/gdm.d/00-login-screen
dconf update; chmod a+rx -R /etc/dconf

# configurar ssh
echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config
mkdir -p /root/.ssh && sh -c 'curl -fsSL  https://github.com/benigaslo/docs/releases/download/id_rsa/id_rsa.pub > /root/.ssh/authorized_keys'

# instalar clickcontrol
wget https://github.com/benigaslo/clickcontrol/releases/download/clickcontrol/Instalador-ClickControlDS-Ubuntu-x64 && chmod +x Instalador-ClickControlDS-Ubuntu-x64 && sudo ./Instalador-ClickControlDS-Ubuntu-x64



