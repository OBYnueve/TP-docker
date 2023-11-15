FROM debian:buster

COPY srcs/config/default /etc/nginx/sites-available
COPY srcs/links /var/www
COPY srcs/cerfs /etc/nginx/certs/
COPY srcs/config/delete.sh /var/www
COPY srcs/index.html .

EXPOSE 80
EXPOSE 443

WORKDIR /var/www

CMD tail -f NULL