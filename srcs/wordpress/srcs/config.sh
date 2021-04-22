cp default /etc/nginx/conf.d/default.conf
cd /var/www
mkdir html
cp /srcs/wordpress-5.7.1.tar.gz html/
cd html
tar -xf wordpress-5.7.1.tar.gz
cp /srcs/wp-config.php wordpress/
rc-service php-fpm7 start
rc-service nginx start

sleep 5

while [ $(/usr/bin/pgrep nginx | wc -l) -gt 0 ]; do
    if [ $(/usr/bin/pgrep php-fpm | wc -l) -gt 0 ]; then
        sleep 2
    else
        exit 1
    fi
done