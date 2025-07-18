<h1 align="center">🐳 Inception</h1>

<p align="center">
	<b><i>Inception is a DevOps project from 42 school where you containerize multiple services (like Nginx, WordPress, MariaDB) using Docker and Docker Compose, focusing on system administration, security, and infrastructure automation.</i></b><br>
</p>

<p align="center">
  <img alt="Docker" src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white"/>
  <img alt="MariaDB" src="https://img.shields.io/badge/MariaDB-003545?logo=mariadb&logoColor=white&style=for-the-badge"/>
  <img alt="Nginx" src="https://img.shields.io/badge/Nginx-009639?logo=nginx&logoColor=white&style=for-the-badge"/>
  <img alt="WordPress" src="https://img.shields.io/badge/WordPress-21759B?logo=wordpress&logoColor=white&style=for-the-badge"/>
</p>

## 📚 Table of Contents

- [📚 Table of Contents](#-table-of-contents)
- [📣 Introduction](#-introduction)
- [📦 Installation](#-installation)
- [📝 Usage](#-usage)
- [🌐 Links](#-links)
- [📎 References](#-references)

## 📣 Introduction

The goal of the project is to containerize a simple web application infrastructure using Docker Compose.

The project involves setting up three mandatory containers - a MariaDB database, an NGINX web server, and a WordPress instance.

By completing this project, I learned how to architect a production-like environment using Docker networking and persist data in volumes. The bonus services also allowed me to dig deeper into configuring real-world web applications.

Overall, Inception gave me valuable hands-on experience in understanding core Docker concepts that I will be able to apply in future projects and roles as a software engineer.

## 📦 Installation

> [!WARNING]
> Before running the project, you must add a line inside `/etc/hosts`.

```
127.0.0.1   rbulanad.42.fr
```

Clone the repository from GitHub:
```sh
git clone https://github.com/RedWrks/Inception.git
```

Use the env.template to create the required .env
```sh
cp srcs/env.template srcs/.env
```

Build and run the `Inception` project containers:
```sh
make
```
> [!NOTE]
> This command will build the containers with docker-compose and run them.

## 📝 Usage

Display each containers status:
```sh
make status
```

Stop the running containers:
```sh
make stop
```
> [!NOTE]
> The containers take their sweet time to shut down, if you are impatient use the classic CTRL-C during the shutdown process (at your own risk).

Purge and clean the containers:
```sh
make clean
```

The good ol' stop and clean:
```sh
make fclean
```

## 🌐 Links

| Service | Accessible link |
| ----- | ----- |
| Wordpress | <a href="https://rbulanad.42.fr/">https://rbulanad.42.fr/</a> |

## 📎 References

- [Docker compose overview](https://docs.docker.com/engine/reference/commandline/compose/)
- [WP-CLI](https://wp-cli.org/)
- [php-fpm configuration](https://www.php.net/manual/en/install.fpm.configuration.php)
- [Adminer installation](https://kinsta.com/blog/adminer/)
- [MySQL queries](https://www.php.net/manual/en/function.mysql-query.php)

[⬆ Back to Top](#-table-of-contents)
