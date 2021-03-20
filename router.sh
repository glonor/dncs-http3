export DEBIAN_FRONTEND=noninteractive

sudo su


#INTERFACE CONFIGURATION
#adds IP address to the interface
ip addr add 192.168.0.1/30 dev enp0s8
#brings the interface up
ip link set enp0s8 up

#adds IP address to the interface
ip addr add 192.168.2.1/30 dev enp0s9
#brings the interface up
ip link set enp0s9 up


#IP FORWARDING
sysctl net.ipv4.ip_forward=1 #enables IP forwarding