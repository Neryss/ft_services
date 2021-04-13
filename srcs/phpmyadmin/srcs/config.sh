cp default /etc/nginx/conf.d/default.conf
cd /var/www/
mkdir html
cd html
mkdir phpMyAdmin
tar -xvf /srcs/phpMyAdmin-4.9.7-all-languages.tar.gz > /dev/null
mv phpMyAdmin-4.9.7-all-languages/* phpMyAdmin
rm -rf phpMyAdmin-4.9.7-all-languages.tar.gz
rm -rf phpMyAdmin-4.9.7-all-languages
cd phpMyAdmin
cp /srcs/config.sample.inc.php ./config.inc.php
cp /srcs/wp-config.php ./
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