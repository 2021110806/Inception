FROM	debian:bullseye

# 패키지 목록 업데이트 및 필요한 패키지 설치
RUN		apt-get update && apt-get install -y \
		curl \
		mariadb-client \
		php7.4 \
		php7.4-fpm \
		php7.4-mysql

# WP-CLI 설치
RUN		curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
		&& chmod +x wp-cli.phar \
		&& mv wp-cli.phar /usr/local/bin/wp
	
RUN		mkdir -p /run/php && chmod 777 /run/php

# 실행 스크립트 복사 및 실행 권한 부여
COPY	./tools/wordpress_setting.sh /wordpress_setting.sh
RUN		chmod 777 /wordpress_setting.sh

CMD		["./wordpress_setting.sh"]

EXPOSE	9000