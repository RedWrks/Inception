FROM alpine:3.21.2

#install Nginx in container and OpenSSL (for TLS)
RUN apk update && apk add nginx openssl

#create need directories
RUN mkdir -p /run/nginx /etc/nginx/ssl /var/www/html /tmp

#creating certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/rbula-self.key \
	-out /etc/nginx/ssl/rbula-self.crt \
	-subj "/C=FR/ST=PACA/L=Nice/O=42/OU=rbulanad/CN=rbulanad.42.fr"

#modifying perms for safety (thanks master brandon)
RUN chmod -R 755 /var/www/html

#copying important files (config, home page, script)
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/var_handler.sh /tmp/var_handler.sh

#rendre le script executable
RUN chmod +x /tmp/var_handler.sh

#allowing port
EXPOSE 443

#launch the script
CMD ["sh", "/tmp/var_handler.sh"]
