#!/bin/bash

#CRIANDO  A PASTA  DE SOCKT DO MARIADB 
mkdir /run/mysqld/

# Permissão de mysql para pasta
chown -R mysql:mysql /var/lib/mysql

#EFETUANDO A PERMISSÃO PARA MYSQL TER O ACESSO
chown mysql:mysql /run/mysqld/

#EFETUANDO O COMANDO PARA ADICIONAR A TABELA MYSQL.USER
mysql_install_db --user=mysql --ldata=/var/lib/mysql/ --basedir=/usr/ > /dev/null 2>&1

#EXECUTANDO ALTERAÇÃO DE USUARIO E CRIANDO O USUARIO O WIKI  E CRIANDO A TABELA!
bash /etc/init.d/run.sh &

#STARTANDO O SERVIÇO DO MYSQL 
/usr/bin/mysqld_safe > /dev/null 2>&1
