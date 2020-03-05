FROM alpine:3.8

RUN  apk --no-cache upgrade \
     && apk --no-cache add nginx \
     && mkdir  /run/nginx/ \
     && rm -f /etc/nginx/conf.d/default.conf \
     && rm -f /etc/nginx/nginx.conf \
     && adduser -D -g 'www' www \
     && chown -R www:www /var/lib/nginx \
     && chown -R www:www /var/www 


EXPOSE 80
COPY  nginx.conf  /etc/nginx/
COPY  default.conf /etc/nginx/conf.d/
CMD ["/usr/sbin/nginx", "-g", "daemon off;"] 


