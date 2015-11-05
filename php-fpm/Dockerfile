FROM nmcteam/php56
MAINTAINER Tomasz Jonik <tomasz@hurricane.works>

# Install packages
RUN apt-get update && apt-get install -y --force-yes php5-redis

# Configure PHP and extensions
RUN /usr/sbin/php5enmod redis
RUN rm -rf /var/lib/apt/lists/*

CMD ["php5-fpm"]

EXPOSE 9000


