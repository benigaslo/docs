# Bridge KVM

/etc/netplan/00-kvm-bridges.yml
```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp1s0:
      dhcp4: no
  bridges:
    br0:
      interfaces: [ enp1s0 ]
      addresses: [10.10.10.10/24]
      mtu: 1500
      parameters:
        stp: true
        forward-delay: 4
      dhcp4: no
      dhcp6: no
```

virt-manager VirtualNetwork
```xml
<network>
  <name>br0</name>
  <uuid>fe8277ba-458f-499f-8e30-ce05201fc6e2</uuid>
  <forward mode="bridge"/>
  <bridge name="br0"/>
</network>
```
