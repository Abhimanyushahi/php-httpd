FROM centos:latest

RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum install httpd php -y
RUN sed -i 's/listen.acl_users/;listen.acl_users/g' /etc/php-fpm.d/www.conf
RUN sed -i 's/listen.acl_groups/;listen.acl_groups/g' /etc/php-fpm.d/www.conf
COPY index.php /var/www/html
WORKDIR /app
COPY service.sh .
RUN chmod +x service.sh
RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf
RUN mkdir /var/run/php-fpm
CMD ["./service.sh"]
EXPOSE 80

