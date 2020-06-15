hostnamectl set-hostname cdn1.promoviesonline.com
mkdir /home/public_html/
apt -y install wget
cd /etc/apt/sources.list.d/
wget -q https://repo.b-cdn.net/debian-buster/sources.tar.gz
tar -zxvf sources.tar.gz
rm -rf sources.tar.gz
cd ~


apt update
apt -t buster-backports install curl gnupg2 -y
curl -fsSL https://nginx.org/keys/nginx_signing.key | apt-key add -
wget -q https://packages.sury.org/php/apt.gpg
apt-key add apt.gpg
rm -rf apt.gpg
apt update && apt upgrade -y && apt -t buster-backports upgrade -y


apt -t buster-backports -y install nano screen net-tools nload zip unzip htop iotop lshw smartmontools hdparm cpuid dsniff dnsutils iperf3 sysstat rsync git
#nano /etc/resolv.conf; /etc/init.d/networking restart
apt -t buster-backports -y upgrade iptables;
apt -t buster-backports -y install firewalld;
systemctl enable firewalld.service;
systemctl start firewalld.service;

firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --permanent --zone=public --add-service=mysql
firewall-cmd --permanent --add-service=ntp
firewall-cmd --permanent --zone=public --add-port=9399/tcp
firewall-cmd --reload


#nano /etc/ssh/sshd_config
service ssh restart
#apt -y install certbot
openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

apt -y install nginx nginx-module-geoip nginx-module-geoip-dbg
systemctl start nginx.service
apt -y install php7.4 php7.4-fpm php7.4-common php7.4-cli php7.4-dev php7.4-mysql php7.4-curl php7.4-gd php7.4-mbstring php7.4-json php7.4-zip

chown -R nginx:nginx /var/lib/php/sessions
apt -y remove apache*
apt autoremove -y
cd /usr/lib/php/20190902/

wget -q https://repo.b-cdn.net/debian-buster/ixed.7.4.lin
cd /etc/php/7.4/mods-available
wget -q https://repo.b-cdn.net/debian-buster/sourceguardian.ini
ln -s /etc/php/7.4/mods-available/sourceguardian.ini /etc/php/7.4/fpm/conf.d/20-sourceguardian.ini
ln -s /etc/php/7.4/mods-available/sourceguardian.ini /etc/php/7.4/cli/conf.d/20-sourceguardian.ini
cd /


wget -q https://repo.b-cdn.net/debian-buster/proxy-confs-7-4.zip
unzip proxy-confs-7-4.zip
rm -f proxy-confs-7-4.zip
cd /

apt -y install libmaxminddb0 libmaxminddb-dev
wget -q https://github.com/maxmind/geoipupdate/releases/download/v4.2.2/geoipupdate_4.2.2_linux_amd64.deb
apt -y install ./geoipupdate_4.2.2_linux_amd64.deb
rm -rf geoipupdate_4.2.2_linux_amd64.deb

cd /etc/
wget -q https://repo.b-cdn.net/debian-buster/GeoIP.conf -O GeoIP.conf
cd ~
geoipupdate
chown -R nginx:nginx /home/
systemctl restart nginx
systemctl restart php7.4-fpm
apt autoclean && apt update && apt upgrade -y && apt -t buster-backports upgrade -y && apt autoremove -y



certbot certonly --standalone -d cdn1.promoviesonline.com
nginx -t
chmod 775 -R /home/public_html/
service nginx restart

pip install speedtest-cli
apt-get install -y python-pip
pip install speedtest-cli
pip install speedtest-cli –-upgrade

nginx -t
systemctl restart nginx
php-fpm7.4 -t
systemctl restart php7.4-fpm


cd /tmp
wget https://github.com/sivel/speedtest-cli/archive/master.zip
unzip master.zip
cd speedtest-cli-master/
chmod 755 speedtest.py
mv speedtest.py /usr/local/bin/speedtest-cli
speedtest-cli
