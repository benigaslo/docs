# ====================================================================
# Instalar coses
# ====================================================================

apt update
apt install -y curl openssh-server nmap default-jre plocate ubuntu-restricted-extras vlc chromium-browser gimp inkscape libdvd-pkg mono-complete sssd fusioninventory-agent
apt install -y $(check-language-support)
dpkg-reconfigure libdvd-pkg
apt remove gnome-initial-setup update-notifier thunderbird rhythmbox

snap remove thunderbird
snap remove rhythmbox
snap refresh


curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
apt update
apt install brave-browser


wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# ====================================================================
# Desactivar actualitzacions automatiques snap i apt
# ====================================================================

snap refresh --hold

cat << EOF > /etc/apt/apt.conf.d/90desactivar-unattended-upgrades
APT::Periodic::Unattended-Upgrade "0";
APT::Periodic::Update-Package-Lists "0";
EOF

# ====================================================================
# Configurar escriptori
# ====================================================================

# logo pantalla login
# canviar aplicacions favorites
# deshabilitar canviar d'usuari
# deshabilitar bloqueig de pantalla
# amagar la llista de usuaris a la pantalla de login

mkdir -p /usr/share/pixmaps/logo/
curl -fsSLo /usr/share/pixmaps/logo/logo.svg  https://raw.githubusercontent.com/benigaslo/disseny/master/logo_u.svg

# sh -c 'curl -fsSL  https://raw.githubusercontent.com/benigaslo/disseny/master/logo_u.svg > /usr/share/pixmaps/logo/logo.svg'

cat << EOF > /etc/dconf/profile/user
user-db:user
system-db:benigaslo
EOF

mkdir -p /etc/dconf/db/benigaslo.d/ 

cat << EOF > /etc/dconf/db/benigaslo.d/00_benigaslo_settings
[org/gnome/shell]
favorite-apps = ['firefox_firefox.desktop', 'nautilus.desktop','google-chrome.desktop','libreoffice-writer.desktop'] 

[org/gnome/desktop/lockdown]
disable-user-switching=true
disable-lock-screen=true
EOF

cat << EOF > /etc/dconf/profile/gdm
user-db:user
system-db:gdm
file-db:/usr/share/gdm/greeter-dconf-defaults
EOF

mkdir -p /etc/dconf/db/gdm.d/ 

cat << EOF > /etc/dconf/db/gdm.d/00-login-screen
[org/gnome/login-screen]
disable-user-list=true
logo='/usr/share/pixmaps/logo/logo.svg'
banner-message-enable=true
banner-message-text='Accediu amb usuari  @edu.gva.es,\no amb  pro/pro'
EOF

dconf update 
chmod a+rx -R /etc/dconf

# Deshabilitar la hibernacio

systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

# ====================================================================
# configurar ssh
# ====================================================================

echo 'PasswordAuthentication no' > /etc/ssh/sshd_config.d/PasswordAuthentication.conf
mkdir -p /root/.ssh 
curl -fsSLo /root/.ssh/authorized_keys https://github.com/benigaslo/docs/releases/download/id_rsa/id_rsa.pub
# sh -c 'curl -fsSL  https://github.com/benigaslo/docs/releases/download/id_rsa/id_rsa.pub > /root/.ssh/authorized_keys'

# ====================================================================
# Configurar IDDigital
# ====================================================================

# apt install -y sssd

touch /etc/sssd/sssd.conf
chmod 600 /etc/sssd/sssd.conf

cat << EOF > /etc/sssd/sssd.conf
[sssd]
config_file_version = 2
services = nss, pam, ssh
domains = EDU.GVA.ES

[nss]
filter_users = root
filter_groups = root
override_shell = /bin/bash

[pam]
[sudo]
[domain/EDU.GVA.ES]
id_provider = ldap
auth_provider = krb5
chpass_provider = krb5
access_provider = simple
autofs_provider = none
enumerate = false
ignore_group_members = true
dns_discovery_domain = ldapad.edu.gva.es
debug_level = 0
ldap_uri = ldap://ldapad.edu.gva.es
ldap_search_base = dc=edu,dc=gva,dc=es
ldap_schema = ad
ldap_id_mapping = true
ldap_user_object_class = user
fallback_homedir = /home/%u
ldap_user_principal = nonExistingAttribute
ldap_user_name = sAMAccountName
ldap_user_shell = loginShell
ldap_user_gecos = displayName
ldap_user_uid_number = uidName
ldap_group_object_class = group
ldap_user_gid_number = GIDNumer
ldap_access_order = expire
ldap_account_expire_policy = ad
ldap_force_upper_case_realm = true
ldap_referrals = false
ldap_tls_reqcert = demand
ldap_tls_cacert = /etc/pki/tls/certs/ca-bundle.crt
ldap_tls_cacertdir = /etc/pki/tls/certs
ldap_sudo_search_base = cn=EDUCACION,dc=edu,dc=gva,dc=es
 
ldap_default_bind_dn = cn=consulta_DA,ou=educacion,dc=edu,dc=gva,dc=es
ldap_default_authtok_type = password
ldap_default_authtok = uLt8w_uf
krb5_server = ldapad.edu.gva.es
krb5_kpasswd = ldapad.edu.gva.es
krb5_realm = EDU.GVA.ES
krb5_ccachedir = /tmp
krb5_ccname_template = FILE:%d/krb5cc_%U_XXXXXX
krb5_auth_timeout = 30

[domain/ALU.EDU.GVA.ES]
id_provider = ldap
auth_provider = krb5
chpass_provider = krb5
access_provider = simple
autofs_provider = none
enumerate = false
dns_discovery_domain = ldapad.edu.gva.es
debug_level = 0
ldap_uri = ldap://ldapad.edu.gva.es
ldap_search_base = dc=edu,dc=gva,dc=es
ldap_schema = ad
ldap_id_mapping = true
ldap_user_object_class = user
fallback_homedir = /home/%u
ldap_user_principal = nonExistingAttribute
ldap_user_name = sAMAccountName
ldap_user_shell = loginShell
ldap_user_gecos = displayName
ldap_user_uid_number = uidName
ldap_group_object_class = group
ldap_user_gid_number = GIDNumer
ldap_access_order = expire
ldap_account_expire_policy = ad
ldap_force_upper_case_realm = true
ldap_referrals = false
ldap_tls_reqcert = demand
ldap_tls_cacert = /etc/pki/tls/certs/ca-bundle.crt
ldap_tls_cacertdir = /etc/pki/tls/certs
ldap_sudo_search_base = cn=EDUCACION,dc=edu,dc=gva,dc=es
 
ldap_default_bind_dn = cn=consulta_DA,ou=educacion,dc=edu,dc=gva,dc=es
ldap_default_authtok_type = password
ldap_default_authtok = uLt8w_uf
krb5_server = ldapad.edu.gva.es
krb5_kpasswd = ldapad.edu.gva.es
krb5_realm = ALU.EDU.GVA.ES
krb5_ccachedir = /tmp
krb5_ccname_template = FILE:%d/krb5cc_%U_XXXXXX
krb5_auth_timeout = 30
EOF

cat << EOF > /etc/pam.d/common-auth
auth	[success=2 default=ignore]	pam_unix.so nullok
auth	[success=1 default=ignore]	pam_sss.so use_first_pass
auth	requisite			pam_deny.so
auth	required			pam_permit.so
auth	optional			pam_cap.so 
EOF

cat << EOF > /etc/pam.d/common-session
session	[default=1]	pam_permit.so
session	requisite	pam_deny.so
session	required	pam_permit.so
session optional	pam_umask.so
session	required	pam_unix.so 
session required	pam_mkhomedir.so skel=/etc/skel umask=0077
session	optional	pam_sss.so 
session	optional	pam_systemd.so 
EOF

## Comprovar /etc/nsswitch.conf
cat << EOF > /etc/nsswitch.conf
passwd:         files systemd sss
group:          files systemd sss
shadow:         files sss
gshadow:        files
hosts:          files mdns4_minimal [NOTFOUND=return] dns
networks:       files
protocols:      db files
services:       db files sss
ethers:         db files
rpc:            db files
netgroup:       nis sss
automount:      sss
EOF

# ====================================================================
# FusionInventory
# ====================================================================

# apt install -y fusioninventory-agent

cat << EOF > /etc/fusioninventory/agent.cfg
server = http://inventario.apografis.edu.gva.es/apografis/plugins/fusioninventory/
delaytime = 86399 #1 dia
lazy = 0
scan-homedirs = 0
scan-profiles = 0
html = 0
backend-collect-timeout = 180
force = 0
additional-content =
no-p2p = 0
proxy =
user =
password =
ca-cert-dir =
ca-cert-file =
no-ssl-check = 0
timeout = 180
no-httpd = 0
httpd-ip =
httpd-port = 62354
httpd-trust =
logger = syslog
logfacility = LOG_DAEMON
color = 0
tag = 
debug = 0
include "conf.d/"
EOF

# ====================================================================
# FogClient
# ====================================================================

wget https://github.com/benigaslo/bin/raw/main/SmartInstaller.exe
mono SmartInstaller.exe --server 172.21.44.254
rm SmartInstaller.exe SmartInstaller.log

# instalar clickcontrol
# wget https://github.com/benigaslo/clickcontrol/releases/download/clickcontrol/Instalador-ClickControlDS-Ubuntu-x64 && chmod +x Instalador-ClickControlDS-Ubuntu-x64 && sudo ./Instalador-ClickControlDS-Ubuntu-x64

