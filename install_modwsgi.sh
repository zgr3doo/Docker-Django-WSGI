#!/bin/sh

# Load most recent mod_wsgi
mkdir /modwsgi
cd /modwsgi
wget https://github.com/GrahamDumpleton/mod_wsgi/archive/4.4.13.tar.gz
tar xvf 4.4.13.tar.gz
cd mod_wsgi-4.4.13
./configure
make
make install
echo LoadModule wsgi_module modules/mod_wsgi.so >>  /etc/httpd/conf.modules.d/00-base.conf
echo ServerName localhost >> /etc/httpd/conf/httpd.conf
rm -Rf /modwsgi