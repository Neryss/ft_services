/etc/init.d/mariadb setup
rc-service mariadb start

mysql -u root -e "CREATE USER '${MYSQL_ROOT_USERNAME}'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON * . * TO '${MYSQL_ROOT_PASSWORD}'@'%';"
mysql -u root -e "FLUSH PRIVILEGES;"
mysql -u root -e "CREATE DATABASE wordpress;"
sed -i "s|.*skip-networking.*|#skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
rc-service mariadb restart

if [ `mysql -u root -e "use wordpress; show tables\G" | wc -l` = 0 ]
then
	mysql -u root wordpress < ./wordpress.sql
fi

sleep 5

while [ $(/usr/bin/pgrep mysql | wc -l) -gt 0 ]; do
		sleep 2
done