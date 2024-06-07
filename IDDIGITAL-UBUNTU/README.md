# Identitat Digital en Ubuntu 22.04

## Install
```
apt install sssd 
```

No és necessari:
```
apt install libpam-ldap libpam-mount libpam-modules
```

## Copy
`/etc/sssd/sssd.conf`

```
chmod 600 /etc/sssd/sssd.conf
```

`/etc/pam.d/common-auth`

`/etc/pam.d/common-session`

