# Bridge KVM

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
