# ====================================================================
# Instalar Varios
# ====================================================================
snap install code --classic
snap install intellij-idea-community --classic
snap install thonny


# apt remove xournalpp xaos tuxtype scribus ri-li qstopmotion posterazor onboard musescore3 marble librecad kig gperiodic avogadro intef-exe-appimage gdis hotpotatoes
# apt autoremove
# desinstalar transmission skanlite libgphoto2-6 laby kget kamoso k3b jclic imagination filezilla gparted tuxmath
# groovy-console gestor-particions-kde
# kde-sms thunderbird




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

echo 'PasswordAuthentication no' > /etc/ssh/sshd_config.d/PasswordAuthentication.conf
mkdir -p /root/.ssh 
curl -fsSLo /root/.ssh/authorized_keys https://github.com/benigaslo/docs/releases/download/id_rsa/id_rsa.pub


# ====================================================================
# Afegir a tots els usuaris (inclosos iddigital) als grups necesaris
# ====================================================================

cat << EOF > /etc/security/group.conf
*;*;*;Al;ubridge,libvirt,kvm,wireshark,docker
EOF

cat << EOF > /etc/pam.d/common-auth
auth	[success=2 default=ignore]	pam_unix.so nullok
auth	[success=1 default=ignore]	pam_sss.so use_first_pass
auth	requisite			pam_deny.so
auth	required			pam_permit.so
auth	optional			pam_cap.so 
auth	optional			pam_group.so
EOF

chattr +i /etc/pam.d/common-auth


# ====================================================================
# Docker
# ====================================================================

# [x]  curl -fsSL https://get.docker.com | bash -
# Instalar via ZeroCenter

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
