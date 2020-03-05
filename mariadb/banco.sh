#!/bin/bash

sleep 3

cheque="/tmp/arch"

if [ -e $cheque ]; then
	echo "Arquivos já existe"
	exit 1
else
	
	touch /tmp/arch
	fi


if [ "$MYSQL_ROOT_PASSWORD" = "" ]; then
		MYSQL_ROOT_PASSWORD=`pwgen 16 1`
		echo "[i] MySQL root Password: $MYSQL_ROOT_PASSWORD"
	fi

	MYSQL_DATABASE=${MYSQL_DATABASE:-""}
	MYSQL_USER=${MYSQL_USER:-""}
	MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}

    mysql -uroot mysql -e " SET PASSWORD FOR 'root'@'localhost'=PASSWORD('$MYSQL_ROOT_PASSWORD') ;" > /dev/null 2>&1

if [ -n "$(mysql -uroot -p --password="$MYSQL_ROOT_PASSWORD" -e "SHOW DATABASES LIKE '${MYSQL_DATABASE}';" | grep ${MYSQL_DATABASE})" ]; then
        echo "[!] Database ja existente"
        exit 1
fi



 cat << EOF > $cheque

#!/bin/bash

mysql -uroot mysql  --password="$MYSQL_ROOT_PASSWORD" -e    "GRANT ALL ON *.* TO 'root'@'%' identified by 'wiki' WITH GRANT OPTION ;"

mysql -uroot mysql  --password="$MYSQL_ROOT_PASSWORD" -e     " GRANT ALL ON *.* TO 'root'@'localhost' identified by 'wiki' WITH GRANT OPTION ;"

mysql -uroot mysql  --password="$MYSQL_ROOT_PASSWORD" -e    "  FLUSH PRIVILEGES ; "

mysql -uroot mysql  --password="$MYSQL_ROOT_PASSWORD" -e    "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"

mysql -uroot mysql  --password="$MYSQL_ROOT_PASSWORD" -e	"CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';"
	
mysql -uroot mysql  --password="$MYSQL_ROOT_PASSWORD" -e	"GRANT ALL PRIVILEGES ON * . * TO '$MYSQL_USER'@'%';"

mysql -uroot mysql  --password="$MYSQL_ROOT_PASSWORD" -e	"GRANT ALL PRIVILEGES ON * . * TO '$MYSQL_USER'@'localhost';"

mysql -uroot mysql  --password="$MYSQL_ROOT_PASSWORD" -e	"FLUSH PRIVILEGES;"

mysql -uroot mysql  --password="$MYSQL_ROOT_PASSWORD" -e	"create database $MYSQL_DATABASE;"

EOF
 
 bash /tmp/arch

echo 
echo
echo "FINALIZADO !" 
