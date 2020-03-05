#!/bin/bash

sleep 3

cheque="/tmp/arch.sh"
root="/tmp/sa.sh"

if [ -e $cheque ]; then
	echo "Arquivos já existe"
	exit 1
else
	
	touch /tmp/arch
	fi

if [ -e $root ]; then
	echo "Arquivos já existe"
	exit 1
else
	
	touch /tmp/sa.sh
	fi

if [ "$MYSQL_ROOT_PASSWORD" = "" ]; then
		MYSQL_ROOT_PASSWORD=`pwgen 16 1`
		echo "[i] MySQL root Password: $MYSQL_ROOT_PASSWORD"
	fi

	MYSQL_DATABASE=${MYSQL_DATABASE:-""}
	MYSQL_USER=${MYSQL_USER:-""}
	MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}

  cat << sha > $root
	#!/bin/bash

	mysql -uroot  mysql  -e " UPDATE user SET Password=PASSWORD('$MYSQL_ROOT_PASSWORD') WHERE User='root'; "
 	
	mysql -uroot -p mysql    --password="$MYSQL_ROOT_PASSWORD" -e    "GRANT ALL ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;"

	mysql -uroot -p mysql    --password="$MYSQL_ROOT_PASSWORD" -e     " GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;"

	mysql -uroot -p mysql    --password="$MYSQL_ROOT_PASSWORD" -e    "  FLUSH PRIVILEGES ; "
sha
 
bash /tmp/sa.sh 	

if [ -n "$(mysql -uroot -p --password="$MYSQL_ROOT_PASSWORD" -e "SHOW DATABASES LIKE '${MYSQL_DATABASE}';" | grep ${MYSQL_DATABASE})" ]; then
        echo "[!] Database ja existente"
        exit 1
fi



 cat << EOF > $cheque

#!/bin/bash

mysql -uroot -p mysql  --password="$MYSQL_ROOT_PASSWORD" -e  "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"

mysql -uroot -p mysql  --password="$MYSQL_ROOT_PASSWORD" -e	"CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';"
	
mysql -uroot -p mysql  --password="$MYSQL_ROOT_PASSWORD" -e	"GRANT ALL PRIVILEGES ON * . * TO '$MYSQL_USER'@'%';"

mysql -uroot -p mysql  --password="$MYSQL_ROOT_PASSWORD" -e	"GRANT ALL PRIVILEGES ON * . * TO '$MYSQL_USER'@'localhost';"

mysql -uroot -p mysql  --password="$MYSQL_ROOT_PASSWORD" -e	"FLUSH PRIVILEGES;"

mysql -uroot -p  mysql  --password="$MYSQL_ROOT_PASSWORD" -e "create database $MYSQL_DATABASE;"

EOF
 
 bash /tmp/arch.sh

echo 
echo
echo "FINALIZADO !" 

