FROM ubuntu:latest
RUN apt-get -y update
RUN apt-get install -y apache2 curl
RUN apt-get install -y zip
RUN apt-get install -y unzip
ADD https://www.free-css.com/assets/files/free-css-templates/download/page292/logistica.zip  /var/www/html/
WORKDIR /var/www/html
RUN unzip logistica.zip
RUN cp -rvf logistica/* .
RUN rm -rf logistica logistica.zip
ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]
EXPOSE 80
