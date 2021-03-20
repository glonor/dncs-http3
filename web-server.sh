export DEBIAN_FRONTEND=noninteractive

sudo su

#INTERFACE CONFIGURATION
#set up IP address to the interface
ip addr add 192.168.2.2/30 dev enp0s8
#brings the interface up
ip link set enp0s8 up

ip route add 192.168.0.0/30 via 192.168.2.1

apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
#Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update

#install the latest version of Docker Engine and containerd
apt-get install -y docker-ce docker-ce-cli containerd.io

sudo docker run --name nginx3 -d -p 80:80 -p 443:443/tcp -p 443:443/udp -v /vagrant/docker/confs/http3.nginx.conf:/etc/nginx/nginx.conf -v /vagrant/docker/certs/:/etc/nginx/certs/ -v /vagrant/docker/web/:/etc/nginx/html/ mouezkhelifi/nginx-quic

sudo docker run --name nginx2 -d -p 90:80 -p 643:443/tcp -p 643:443/udp -v /vagrant/docker/confs/http2.nginx.conf:/etc/nginx/nginx.conf -v /vagrant/docker/certs/:/etc/nginx/certs/ -v /vagrant/docker/web/:/etc/nginx/html/ mouezkhelifi/nginx-quic

sudo docker run --name nginx1 -d -p 100:80 -p 743:443/tcp -p 743:443/udp -v /vagrant/docker/confs/tcp.nginx.conf:/etc/nginx/nginx.conf -v /vagrant/docker/certs/:/etc/nginx/certs/ -v /vagrant/docker/web/:/etc/nginx/html/ mouezkhelifi/nginx-quic