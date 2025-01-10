# 프로젝트 이름과 사용자 변수 설정
NAME = inception
USER = minjeongkim

# Docker Compose 파일 위치 지정
COMPOSE_SOURCE = ./srcs/docker-compose.yml

# 사용할 볼륨 경로 설정
# 클러스터용
# MARIADB_VOLUME_PATH = /home/$(USER)/data/mariadb
# WORDPRESS_VOLUME_PATH = /home/$(USER)/data/wordpress
# 노트북용
MARIADB_VOLUME_PATH = /mnt/c/Users/qwer1/바탕화면/inception/data/mariadb
WORDPRESS_VOLUME_PATH = /mnt/c/Users/qwer1/바탕화면/inception/data/wordpress

all: dirs
	@make build
	@make up

dirs:
	@mkdir -p $(MARIADB_VOLUME_PATH) $(WORDPRESS_VOLUME_PATH)

build:
	@docker-compose -f $(COMPOSE_SOURCE) build

up:
	@docker-compose -f $(COMPOSE_SOURCE) up -d

down:
	@docker-compose -f $(COMPOSE_SOURCE) down

start:
	@docker-compose -f $(COMPOSE_SOURCE) start

stop:
	@docker-compose -f $(COMPOSE_SOURCE) stop

clean: stop
	@make down
	@if [ $$(docker ps -aq | wc -l) -gt 0 ]; then docker rm -f $$(docker ps -aq); fi
	@if [ $$(docker images -aq | wc -l) -gt 0 ]; then docker rmi -f $$(docker images -aq); fi
	@docker builder prune -f

fclean: clean
	@docker-compose -f $(COMPOSE_SOURCE) down --volumes
	@docker volume prune -f
	@docker network prune -f

ffclean: fclean
	@sudo rm -rf $(MARIADB_VOLUME_PATH) $(WORDPRESS_VOLUME_PATH)
	@docker system prune -a -f

re: fclean
	@MAKE all

.PHONY: all dirs build up down start stop clean fclean ffclean re
