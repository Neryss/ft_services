cp default /etc/nginx/sites-enabled/default
cp wordpress-5.7.zip /var/www/html
cd /var/www/html
tar -xvf wordpress-5.7.zip
cp /srcs/wp-config.php ./wordpress 
rm -rf wordpress-5.7.zip
service php-fpm7 start
service nginx start