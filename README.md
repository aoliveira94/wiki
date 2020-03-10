Instalação da wiki;

Fazer o git clone;

Alterar docker-compose na parte do banco para suas credencial pessoal, por padrão tudo vai como wiki;

docker-compose up -d

http://localhost

Seguir os passas da instalação;

Na parte de configuração do banco colocar na opção servidor do banco como "mysql" e fornece as credencial que foi fornecida no docker-compose;

Finalizando a instalação copiar o arquivo LocalSettings.php para pasta do nginx onde vai está a pasta wiki.
