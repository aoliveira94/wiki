FROM alpine:3.8

RUN  apk --no-cache upgrade \
     && apk --no-cache add mariadb mariadb-client bash mariadb-server-utils pwgen \
     && rm -f /etc/mysql/my.cnf 
    


     EXPOSE 3306
     COPY my.cnf /etc/mysql/
     COPY start.sh /etc/init.d/
     COPY banco.sh  /etc/init.d/
     CMD ["sh", "/etc/init.d/start.sh"]
