FROM debian:buster

RUN  apt update && apt install -y mariadb-server wget php-fpm php-mysql nginx vim

COPY srcs/config/default /etc/nginx/sites-available
COPY srcs/links /var/www
COPY srcs/cerfs /etc/nginx/certs/
COPY srcs/config/delete.sh /var/www
COPY srcs/index.html .

EXPOSE 80
EXPOSE 443

RUN service mysql start &&  mysql -u root -e "CREATE USER 'oby'@'localhost' IDENTIFIED BY 'azerty123';"
RUN ln -fs /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.2/phpMyAdmin-4.9.2-all-languages.tar.gz && tar -zxvf phpMyAdmin-4.9.2-all-languages.tar.gz 
RUN mv phpMyAdmin-4.9.2-all-languages /var/www/phpMyAdmin && chown -R www-data:www-data /var/www/phpMyAdmin
RUN wget http://wordpress.org/latest.tar.gz && tar xzvf latest.tar.gz && mv wordpress /var/www/wordpress && chown -R www-data:www-data /var/www/wordpress && service mysql start &&  mysql -u root -pazerty123 -e  "CREATE DATABASE wordpress; GRANT ALL PRIVILEGES ON wordpress.* TO oby@localhost; FLUSH PRIVILEGES;"

WORKDIR /var/www

CMD sh delete.sh && tail -F /dev/null