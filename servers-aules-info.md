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

/etc/dhcp/dhcpd.conf
```
...
subnet 10.10.10.0 netmask 255.255.255.0{
    option subnet-mask 255.255.255.0;
    range dynamic-bootp 10.10.10.10 10.10.10.254;
    default-lease-time 21600;
    max-lease-time 43200;
    option routers 192.168.100.1;
    option domain-name-servers 127.0.0.53;
    next-server 10.10.10.10;
}
...
```

/etc/sysctl.d/99-netfilter-bridge.conf
```
net.bridge.bridge-nf-call-ip6tables = 0
net.bridge.bridge-nf-call-iptables = 0
net.bridge.bridge-nf-call-arptables = 0
```

/etc/modules-load.d/br_netfilter.conf
```
br_netfilter
```

/etc/dnsmasq.d/libvirt-daemon
```
bind-interfaces
except-interface=virbr0
```
