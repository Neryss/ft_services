cp default /etc/nginx/conf.d/default.conf
cp wordpress-5.7.zip /var/www/html/
cd /var/www/html
unzip wordpress-5.7.zip
cp /srcs/wp-config.php ./wordpress 
rm -rf wordpress-5.7.zip
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