cp default /etc/nginx/conf.d/default.conf
cp telegraf.conf /etc/telegraf.conf.d/
cd /var/www
mkdir html
cp /srcs/wordpress-5.7.zip html/
cd html
unzip wordpress-5.7.zip > /dev/null
cp /srcs/wp-config.php wordpress/
rm -rf wordpress-5.7.zip
rc-service php-fpm7 start
rc-service nginx start
rc-service telegraf start

sleep 5

while [ $(/usr/bin/pgrep nginx | wc -l) -gt 0 ]; do
    if [ $(/usr/bin/pgrep php-fpm | wc -l) -gt 0 ]; then
        sleep 2
    else
        exit 1
    fi
done