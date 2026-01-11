FROM		debian:oldstable

RUN			apt-get update && apt-get install \
            php8.2-fpm \
            php8.2-mysql \
            php8.2-curl \
            php8.2-gd \
            php8.2-intl \
            php8.2-mbstring \
            php8.2-soap \
            php8.2-xml \
            php8.2-zip \
            mariadb-client \
            php8.2-mysqli \
            wget \
            curl \
            -y && \
            ln -s /usr/sbin/php-fpm8.2 /usr/local/bin/php-fpm && \
            apt clean && \
            rm -rf /var/lib/apt/lists/*

# Install WP-CLI
RUN         curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
            chmod +x wp-cli.phar && \
            mv wp-cli.phar /usr/local/bin/wp

WORKDIR		/var/www/wordpress

COPY		config/www.conf /etc/php/8.2/fpm/pool.d/

COPY		tools/setup_wordpress.sh /usr/local/bin/

RUN			chmod +x /usr/local/bin/setup_wordpress.sh

EXPOSE		9000

ENTRYPOINT	["/usr/local/bin/setup_wordpress.sh"]