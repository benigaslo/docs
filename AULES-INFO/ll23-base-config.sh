# ====================================================================
# Instalar Varios
# ====================================================================

apt remove xournalpp xaos tuxtype scribus ri-li qstopmotion posterazor onboard musescore3 marble librecad kig gperiodic avogadro intef-exe-appimage gdis hotpotatoes

# desinstalar transmission skanlite libgphoto2-6 laby kget kamoso k3b jclic imagination filezilla gparted tuxmath

# groovy-console gestor-particions-kde


# kde-sms

apt update
apt install -y curl

curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
sudo add-apt-repository -y ppa:gns3/ppa

apt update

apt install -y openssh-server pssh nmap tree plocate default-jre wireshark ubuntu-restricted-extras vlc chromium-browser gimp inkscape dia git nodejs gns3-gui bridge-utils virt-manager

curl -fsSL https://get.docker.com | bash -

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

snap install code --classic
snap install kdenlive
snap install audacity

snap remove thunderbird

snap refresh

apt remove rhythmbox deja-dup

# ==============
# Flickering bug
# ==============

cat << EOF > /etc/default/grub.d/06-lliurex-cmdline.cfg
GRUB_CMDLINE_LINUX_DEFAULT="net.ifnames=0 quiet splash intel_iommu=igfx_off rw"
EOF

update-grub

# =============================================
# Afegir usuaris
# =============================================

useradd -m -p "\$y\$j9T\$BkfsfC01PB3SIXQCu/KyO1\$sm4OFcrP3m2RFhsGBRHF6AX1AImPKOq6AxHlkXKfo04" -s /bin/bash alu
useradd -m -p "\$y\$j9T\$gZ.2jbvd92uRZ6RYUMl5p0\$zv4D/6oKY2EqErtTrSjOcNQZ2lQuP7YzIuO3Nbzsmm9" -s /bin/bash pro

# ====================================================================
# configurar ssh
# ====================================================================

# echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config
echo 'PasswordAuthentication no' > /etc/ssh/sshd_config.d/PasswordAuthentication.conf
mkdir -p /root/.ssh 
curl -fsSLo /root/.ssh/authorized_keys https://github.com/benigaslo/docs/releases/download/id_rsa/id_rsa.pub
# sh -c 'curl -fsSL  https://github.com/benigaslo/docs/releases/download/id_rsa/id_rsa.pub > /root/.ssh/authorized_keys'


# ====================================================================
# Afegir a tots els usuaris (inclosos iddigital) als grups necesaris
# ====================================================================

# magicament el meu usuari g.falcoperez esta afegit al grup docker
#cat << EOF > /etc/security/group.conf
#*;*;*;Al;ubridge,libvirt,kvm,wireshark,docker,sudo,adm
#EOF


# ====================================================================
# Docker
# ====================================================================

# curl -fsSL https://get.docker.com | bash -

# Configurar la red default docker
mkdir -p /etc/docker/
cat << EOF > /etc/docker/daemon.json
{
  "bip": "10.0.100.1/24",
  "default-address-pools": [
    {
      "base": "10.1.0.0/16",
      "size": 24
    }
  ]
}
EOF
