FROM	debian:bullseye

# Nginx와 OpenSSL 설치
RUN		apt-get update && \
    	apt-get install -y nginx openssl

# SSL 인증서 디렉터리 생성
RUN		mkdir -p /etc/nginx/ssl/ && \
		chmod 777 /etc/nginx/ssl

# SSL 인증서 생성
RUN		openssl req -newkey rsa:2048 -x509 -days 365 -nodes \
		-keyout /etc/nginx/ssl/nginx.pem \
		-out /etc/nginx/ssl/nginx.crt \
    	-subj "/C=KR/ST=Seoul/L=Seoul/O=42/CN=$DOMAIN_NAME"

RUN		chmod +r  /etc/nginx/ssl/nginx.pem && \
		chmod +r  /etc/nginx/ssl/nginx.crt

# Nginx 설정 파일 복사
COPY	conf/default /etc/nginx/sites-available/default

# Nginx 시작
CMD		["nginx", "-g", "daemon off;"]

EXPOSE	443