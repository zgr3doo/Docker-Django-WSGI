#
#                        ##         .
#                  ## ## ##        ==
#               ## ## ## ## ##    ===
#           /"""""""""""""""""\___/ ===
#      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
#           \______ o           __/ 
#             \    \         __/ 
#              \____\_______/
#
# Django - Docker Container
#
# ver: 0.6
#

FROM centos:7
COPY install_modwsgi.sh /install_modwsgi.sh
COPY install_python_tools.sh /install_python_tools.sh

RUN yum -y update && \
	yum -y install epel-release httpd git wget vim && \
	yum -y install python python-setuptools python-devel httpd-devel mysql-devel && \
	yum -y install libtiff-devel libjpeg-devel libzip-devel freetype-devel lcms2-devel libwebp-devel tcl-devel tk-devel && \
	yum -y groupinstall "Development tools" && \
	/install_modwsgi.sh && \
	/install_python_tools.sh && \
	mkdir /var/www/html/client

COPY vhosts.conf /etc/httpd/conf.d/vhosts.conf

EXPOSE 80

# Start the service
CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"]