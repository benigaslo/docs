Identitat Digital en Ubuntu 22.04

```
apt install sssd libpam-ldap  libpam-modules
```

`/etc/sssd/sssd.conf`

```
chmod 600 /etc/sssd/sssd.conf
```

`/etc/pam.d/common-auth`

`/etc/pam.d/common-session`

`/usr/share/pam-configs/ldap`

`/usr/share/pam-configs/sss
