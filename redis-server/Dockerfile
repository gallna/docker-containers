FROM ubuntu:trusty
MAINTAINER Tomasz Jonik <tomasz@hurricane.works>

# Install redis-server package
RUN apt-get update && apt-get install -y --force-yes redis-server

CMD ["redis-server"]

EXPOSE 6379


