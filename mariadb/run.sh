#!/bin/bash

sleep 3

cheque=/tmp/create.sh

if [ "$MYSQL_ROOT_PASSWORD" = "" ]; then
		MYSQL_ROOT_PASSWORD=`pwgen 16 1`
		echo "[i] Senha de root do MSQL:$MYSQL_ROOT_PASSWORD"
	fi

	MYSQL_DATABASE=${MYSQL_DATABASE:-""}
	MYSQL_USER=${MYSQL_USER:-""}
	MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}


 if [ -e $cheque ]; then
	  echo "Arquivos já existe"
     exit 1
else
	touch /tmp/create.sh 
   fi



cat << EOF > $cheque
mysql -uroot -e  "GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;"
mysql -uroot -e  "SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;"
mysql -uroot -e  "FLUSH PRIVILEGES ;"
EOF

bash $cheque > /dev/null 2>&1

sleep 1

        if [ -n "$(mysql -uroot -p --password="$MYSQL_ROOT_PASSWORD" -e "SHOW DATABASES LIKE '${MYSQL_DATABASE}';" | grep ${MYSQL_DATABASE})" ]; then
        echo "[!] Database já existe"
        exit 1
        

        else 
                echo "Criando o data base"
                  mysql -uroot -p  --password="$MYSQL_ROOT_PASSWORD" -e "create database $MYSQL_DATABASE;" 
            fi

        if [ -n "$(mysql -uroot -p mysql --password="$MYSQL_ROOT_PASSWORD" -e " select User from user where User='${MYSQL_USER}';" | grep ${MYSQL_USER})" ]; then
            echo " [!] Usuario ja existe"
            exit 1

            else 
                echo "[!] Criando Usuario"
                   mysql -uroot -p mysql --password="$MYSQL_ROOT_PASSWORD" -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" 
                   mysql -uroot -p mysql --password="$MYSQL_ROOT_PASSWORD" -e "CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';" 
                   mysql -uroot -p mysql --password="$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON * . * TO '$MYSQL_USER'@'%';"  
                   mysql -uroot -p mysql --password="$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON * . * TO '$MYSQL_USER'@'localhost';" 
                   mysql -uroot -p mysql --password="$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;" 
                fi

echo 
echo 
echo "[!] Finalizado"

