FROM alpine:3.8

RUN apk --no-cache upgrade \
    && apk --no-cache add php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip  php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd  php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype php7-mysqlnd php7-calendar php7-memcached php7-mbstring php7-fileinfo php7 \
    && adduser -D -g 'www' www \
    && mkdir /var/www/ \
    && chown -R www:www /var/lib/php7 \
    && chown -R www:www /var/www 
    

    EXPOSE 9000
    COPY www.conf /etc/php7/php-fpm.d/
    CMD ["php-fpm7", "-F"]
    

