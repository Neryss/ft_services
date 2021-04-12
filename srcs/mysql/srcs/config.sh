/etc/init.d/mariadb setup
rc-service mariadb start

mysql -u root -e "CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON * . * TO 'admin'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;"

mysql -u root -e "CREATE DATABASE wordpress;"

sleep 5

while [ $(/usr/bin/pgrep mysql | wc -l) -gt 0 ]; do
		sleep 2
done