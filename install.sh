#!/bin/bash
#
# Ref: https://www.raspberrypi.org/documentation/configuration/wireless/access-point-routed.md

# Update Repository
apt update && apt upgrade -y

# Install necessary softwares
apt install -y apache2 mariadb-server php php-common php-mysql php-json php-mbstring php-apcu git hostapd dnsmasq gammu gammu-smsd
DEBIAN_FRONTEND=noninteractive apt install -y netfilter-persistent iptables-persistent
apt autoremove

# Enable necessary services
systemctl unmask hostapd
systemctl enable hostapd

# Configure access point
mv /etc/dhcpcd.conf /etc/dhcpcd.conf.orig
cp -f access_point/dhcpcd.conf /etc/dhcpcd.conf
cp -f access_point/routed-ap.conf /etc/sysctl.d/routed-ap.conf
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
netfilter-persistent save
mv -f /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
cp -f access_point/dnsmasq.conf /etc/dnsmasq.conf
rfkill unblock wlan
cp -f access_point/hostapd.conf /etc/hostapd/hostapd.conf

# Configure smsd
cp -f gammu/20-wavecom.rules /etc/udev/rules.d/20-wavecom.rules
mv -f /etc/gammu-smsdrc /etc/gammu-smsdrc.orig
cp -f gammu/gammu-smsdrc /etc/gammu-smsdrc
git clone https://github.com/back2arie/Kalkun.git /var/www/html
mysql < kalkun/prep.sql
zcat /usr/share/doc/gammu-smsd/examples/mysql.sql.gz | mysql smsbox
cp -f /var/www/html/media/db/mysql_kalkun.sql /var/www/html/media/db/mysql_kalkun.sql.orig
sed -i 's/utf8mb4_0900_ai_ci/utf8mb4_unicode_ci/g' /var/www/html/media/db/mysql_kalkun.sql
mysql smsbox < /var/www/html/media/db/mysql_kalkun.sql
cp -f kalkun/database.php /var/www/html/application/config/database.php
cp -f kalkun/kalkun_settings.php /var/www/html/application/config/kalkun_settings.php
mkdir /var/www/html/application/logs
chmod 777 /var/www/html/application/logs
mysql smsbox < kalkun/fin.sql

# Install adminer
wget "https://www.adminer.org/latest-mysql-en.php" -O /var/www/html/adminer.php
wget "https://raw.githubusercontent.com/vrana/adminer/master/designs/pappu687/adminer.css" -O /var/www/html/adminer.css
