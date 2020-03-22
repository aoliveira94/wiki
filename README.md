Instalação da wiki em Docker
------------------------------------------------------------
REQUISITOS
------------
* Docker 
* Docker compose
------------------
LINKS PARA INSTALAÇÃO 
---------------------
Docker - Engine
----------
https://docs.docker.com/install/linux/docker-ce/debian/
----------------------
Docker compose
-------------
https://docs.docker.com/compose/install/
-------------
Procedimentos
--------------------------------------------------

Fazer o git clone;

Alterar docker-compose na parte do banco para suas credencial pessoal, padrão vai como wiki;

docker-compose up -d

http://localhost

Seguir o passo a passado da instalação;

Na parte de configuração do banco colocar na opção servidor do banco como "mysql" e fornecer as credencial que foi fornecida no docker-compose;

Finalizando a instalação copiar o arquivo LocalSettings.php para pasta do wiki onde vai está montada na pasta do nginx
