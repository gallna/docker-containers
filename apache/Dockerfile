FROM ubuntu:vivid
MAINTAINER Tomasz Jonik <tomasz@hurricane.works>

# Install base packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -yq install \
        git \
        curl \
        apache2 \
        libapache2-mod-php5 \
        php5-mysql \
        php5-mcrypt \
        php5-curl \
        php5-mysql \
        php5-pgsql \
        php5-memcached \
        php5-xdebug \
        php-pear

# Configure PHP and extensions
RUN /usr/sbin/php5enmod mcrypt pdo_mysql pdo_pgsql xdebug memcached
RUN rm -rf /var/lib/apt/lists/*

# Add composer
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Configure /app folder with app
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html
RUN rm -fr /app
ADD ./src /app

# Configure Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
ADD vhost.conf /etc/apache2/sites-available/
RUN a2dissite 000-default.conf
RUN a2ensite vhost
RUN a2enmod rewrite
RUN service apache2 restart

# Add image configuration and scripts
ADD init.sh /init.sh
RUN chmod 755 /init.sh
CMD ["/init.sh"]

EXPOSE 80
WORKDIR /app


