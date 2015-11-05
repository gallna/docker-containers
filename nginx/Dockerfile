FROM phusion/baseimage
MAINTAINER YOUR NAME <YOUR EMAIL>

RUN add-apt-repository ppa:nginx/development
RUN apt-get update && apt-get install -y nginx

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
