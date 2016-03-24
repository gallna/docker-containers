FROM nginx

# Copy preconfigured locations
ADD conf.d/location /etc/nginx/conf.d/location

# Copy configuration file
ADD conf.d/php-fpm.rancher.conf /etc/nginx/conf.d/default.conf
