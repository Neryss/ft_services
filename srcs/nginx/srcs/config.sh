cp default /etc/nginx/conf.d/default.conf
cd /var/www/
mkdir html
cd html
echo "salut" >> index.html
rc-service nginx start

sleep 5

while [ $(/usr/bin/pgrep nginx | wc -l) -gt 0 ]; do
		sleep 2
done