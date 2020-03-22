Instalação da wiki em Docker
-----------
REQUISITOS
----------------------
* Docker 
* Docker compose
-------------
LINKS PARA INSTALAÇÃO 
---------------------
Docker - Engine
----------
https://docs.docker.com/install/linux/docker-ce/debian/
----------
Docker compose
----------
https://docs.docker.com/compose/install/
-------------
Procedimentos
--------------------------------------------------

* Alterar docker-compose na parte do banco para suas credencial pessoal, padrão vai como wiki.
vim docker-compose.yml
Apos alteração das credencial executar o comando abaixo;
-------
* docker-compose up -d
------------
* Acessar no seu navegador .
    http://localhost
* Seguir o passo a passado da instalação;
---------

* Na parte de configuração do banco na instalação da wiki no vegador colocar na opção servidor do banco como "mysql" e fornecer as credencial que foi fornecida no docker-compose;
---------
* Finalizando a instalação copiar o arquivo LocalSettings.php para pasta da wiki onde vai está montada na pasta do nginx.
--------

OBSERVAÇÃO
---------------------------------
Caso tenha apache ou nginx e banco de dados instalado  no seu sitema, tem que para os serviços deles, para não conflitar com os conteiner do docker.
