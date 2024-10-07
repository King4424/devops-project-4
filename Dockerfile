FROM ubuntu:latest
RUN apt-get -y update
RUN apt-get install -y apache2 curl
RUN apt-get install -y zip
RUN apt-get install -y unzip
COPY hightech.zip /var/www/html/
WORKDIR /var/www/html
RUN unzip hightech.zip
RUN cp -rvf hightech-html/* .
RUN rm -rf hightech hightech.zip
ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]
EXPOSE 80
