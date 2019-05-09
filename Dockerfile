FROM php:7.3.5-fpm-alpine3.9
RUN echo http://mirrors.ustc.edu.cn/alpine/v3.9/main > /etc/apk/repositories && \
echo http://mirrors.ustc.edu.cn/alpine/v3.9/community >> /etc/apk/repositories \
&& ln -s /usr/lib /usr/local/lib64 
RUN apk update && apk upgrade \
&& apk add --no-cache curl curl-dev icu icu-dev pcre-dev freetype-dev libpng libpng-dev libjpeg-turbo-dev libwebp-dev zlib-dev libxpm-dev libsodium libsodium-dev postgresql-dev libc-dev libzip-dev libmemcached-dev gettext libxml2-dev   \
&& apk add --no-cache m4 gcc g++ make cmake pkgconf autoconf linux-headers --virtual .build-dependencies \
&& pecl channel-update pecl.php.net \
&& pecl install msgpack igbinary redis mongodb libsodium apcu yar memcached swoole \
&& docker-php-ext-enable msgpack igbinary redis mongodb memcached apcu yar swoole \
&& docker-php-source extract \
&& docker-php-ext-configure gd --with-gettext=/usr/include/ --enable-gettext --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/  --with-webp-dir=/usr/include/ --with-libzip=/usr/include/  \
&& docker-php-ext-install -j$(nproc)  pdo_mysql pdo_pgsql intl zip gd opcache mysqli bcmath sockets pcntl soap calendar dba shmop sysvmsg sysvsem sysvshm \
&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
&& docker-php-source delete \
&& apk del .build-dependencies \
&& rm -rf /tmp/* /usr/share/* /usr/src/*  /usr/libexec 

ENTRYPOINT ["docker-php-entrypoint"]
WORKDIR /var/www/html
STOPSIGNAL SIGQUIT

EXPOSE 9000
CMD ["php-fpm"]