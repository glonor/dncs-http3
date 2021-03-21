export DEBIAN_FRONTEND=noninteractive

sudo su

#INTERFACE CONFIGURATION
#set up IP address to the interface
ip addr add 192.168.0.2/30 dev enp0s8
#brings the interface up
ip link set enp0s8 up

#STATIC ROUTING
#sets the default gateway on router
ip route add 192.168.2.0/30 via 192.168.0.1

echo '192.168.2.2 dncs-http3.duckdns.org' >> /etc/hosts

#CHROME INSTALLATION
wget https://dl-ssl.google.com/linux/linux_signing_key.pub
sudo apt-key add linux_signing_key.pub
sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
apt-get update
apt-get -y install google-chrome-stable
apt-get -y install xorg