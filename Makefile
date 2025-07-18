#!/bin/bash
CLEAR = \033[0m
RESET = \033[0m
GREEN = \033[32m
RED = \033[31m
PURPLE = \033[35m
BOLD = \033[1m
GREY = \033[90m

NAME			= inception
CONTAINERS		= $(shell docker ps -a -q)
VOLUMES			= $(shell docker volume ls -q)
HOSTS			= $(shell cat /etc/hosts | grep -e 'rbulanad.42.fr' | awk '{print $$2}' | tr -d '\n')
EXPECTED		= rbulanad.42.fr

all: start

init:
	@mkdir -p ~/data/wordpress
	@mkdir -p ~/data/mariadb

check-hosts:
	echo "HOSTS: $(HOSTS)"; \
	if [ "$(HOSTS)" = "$(EXPECTED)"  ]; then \
		printf "${CLEAR}${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: Hosts ${GREEN}already ${RESET}configured.\n${RESET}"; \
	else \
		printf "${CLEAR}${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: Hosts are ${RED}not configured${RESET}, please refer to GitHub.\n${RESET}"; \
	fi

start: check-hosts init
	@docker-compose -f ./srcs/docker-compose.yml up -d --build
	@printf "${CLEAR}${RESET}${GREY}────────────────────────────────────────────────────────────────────────────\n${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: ${RED}${BOLD}${NAME} ${RESET}has cooked with ${GREEN}success${RESET}.${GREY}\n${RESET}${GREY}────────────────────────────────────────────────────────────────────────────\n${RESET}"
	@make status

stop:
ifneq ($(CONTAINERS),)
	@docker-compose -f ./srcs/docker-compose.yml down
	@printf "${CLEAR}${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: Containers ${GREEN}successfully ${RESET}stopped.\n${RESET}"
else
	@printf "${CLEAR}${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: There's ${RED}nothing ${RESET}to stop.\n${RESET}"
endif

status:
ifneq ($(CONTAINERS),)
	@printf "${CLEAR}${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: Displaying containers status...\n${RESET}"
	@docker ps -a
else
	@printf "${CLEAR}${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: There's ${RED}nothing ${RESET}to display.\n${RESET}"
endif

clean: stop
ifneq ($(VOLUMES),)
	@docker volume rm $$(docker volume ls -q) > /dev/null
	@docker system prune -a -f > /dev/null
	@clear
	@printf "${CLEAR}${RESET}${GREY}────────────────────────────────────────────────────────────────────────────\n${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: Project cleaned ${GREEN}successfully${RESET}.${GREY}\n${RESET}${GREY}────────────────────────────────────────────────────────────────────────────\n${RESET}"
else
	@printf "${CLEAR}${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: There's ${RED}nothing ${RESET}to clean.\n${RESET}"
endif

fclean: clean
	@sudo rm -rf ~/data

.PHONE: all start stop status clean
