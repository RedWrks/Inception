FROM alpine:3.21.2

# Update and install packages (no cache = not storing package index locally = lighter weight)
RUN apk add --no-cache mysql
RUN apk add --no-cache mariadb mariadb-client

# Copy files
COPY ./tools/db_installer.sh /tmp/db_installer.sh
COPY ./conf/my.cnf /etc/mysql/my.cnf
RUN chmod +x /tmp/db_installer.sh

# Expose ports
EXPOSE 3306

# Run script
CMD ["sh", "/tmp/db_installer.sh"]

#commands to navigate through mariadb (enter mariadb with docker exec -it)
#SHOW DATABASES;
#USE wordpress;
#SHOW TABLES;
#SELECT * FROM [any];
