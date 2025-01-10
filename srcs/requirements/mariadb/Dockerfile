FROM	debian:bullseye

RUN 	apt-get -y update 
		
RUN		apt-get -y install mariadb-server 

COPY	conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY	tools/init.sh ./init.sh

RUN		chmod 044 /etc/mysql/mariadb.conf.d/50-server.cnf
RUN		chmod 755 ./init.sh

CMD		["./init.sh"]

EXPOSE	3306