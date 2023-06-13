# Identitat Digital en Ubuntu 22.04

## Install
```
apt install sssd libpam-ldap  libpam-modules
```

No sé si es necessari:
```
apt install libpam-mount
```

## Copy
`/etc/sssd/sssd.conf`

```
chmod 600 /etc/sssd/sssd.conf
```

`/etc/pam.d/common-auth`

`/etc/pam.d/common-session`

