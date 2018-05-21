FROM php:7-apache

RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=60'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

VOLUME /var/www/html

ENV PUKIWIKI_VERSION 1.5.1

RUN curl -o pukiwiki.zip -SL https://osdn.jp/frs/redir.php?f=%2Fpukiwiki%2F64807%2Fpukiwiki-${PUKIWIKI_VERSION}_utf8.zip \
	&& unzip pukiwiki.zip -d /usr/src/ \
	&& rm pukiwiki.zip \
	&& chown -R www-data:www-data /usr/src/pukiwiki-${PUKIWIKI_VERSION}_utf8

COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
