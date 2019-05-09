# docker-alpine-php7-swoole

## Usage


### Daemon running

```
docker run -d --rm -p 9000:9000 -v /workdir:/var/www/html --name php-swoole joefom/fpm:7.3.5-fpm-alpine3.9
```

### Interactively running

```
docker run -it --rm --name php-swoole joefom/fpm:latest \
php --ri swoole
```

- based ``` php:7.3.5-fpm-alpine3.9 ``` build

- php extension installed: GD mcrypt msgpack igbinary iconv memcached pdo_mysql pdo_pgsql mysqli dom xml curl swoole mongodb redis sodium yar apcu opcache intl bcmath sockets pcntl soap calendar dba shmop sysvmsg sysvsem sysvshm zip

- composer installed