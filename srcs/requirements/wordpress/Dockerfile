FROM alpine:3.21.2

# Update and install PHP
RUN apk update && apk upgrade \
	&& apk add --no-cache \
		php83 \
		php83-fpm \
		php83-mysqli \
		php83-phar \
		php83-iconv \
		curl \
		mariadb-client

# Creating needed dummies
RUN mkdir -p /var/www/html && mkdir -p /run/php
RUN adduser -S nginx && addgroup -S nginx

# Copying installer and configurations
COPY ./conf/www.conf /etc/php83/php-fpm.d/www.conf
COPY ./tools/wp_installer.sh /tmp/wp_installer.sh

# Making installer executable
RUN chmod +x /tmp/wp_installer.sh

# Exposing Wordpress port
EXPOSE 9000

# Working directory
WORKDIR /var/www/html

# Running Wordpress installer script
CMD ["sh", "/tmp/wp_installer.sh"]
