apt update
apt install curl openjdk-17-jre-headless openssh-server
apt remove gnome-initial-setup apt remove update-notifier

# canviar aplicacions favorites
printf 'user-db:user\nsystem-db:benigaslo' > /etc/dconf/profile/user
mkdir -p /etc/dconf/db/benigaslo.d/ && printf "[org/gnome/shell]\nfavorite-apps = ['firefox.desktop', 'nautilus.desktop']" > /etc/dconf/db/benigaslo.d/00_benigaslo_settings
dconf update; chmod a+rx -R /etc/dconf

# instalar clickcontrol
wget https://github.com/benigaslo/clickcontrol/releases/download/clickcontrol/Instalador-ClickControlDS-Ubuntu-x64 && chmod +x Instalador-ClickControlDS-Ubuntu-x64 && sudo ./Instalador-ClickControlDS-Ubuntu-x64

# configurar ssh
echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config
mkdir -p /root/.ssh && sh -c 'curl -fsSL  https://github.com/benigaslo/docs/releases/download/id_rsa/id_rsa.pub >> /root/.ssh/authorized_keys'

