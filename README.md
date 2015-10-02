
                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
           \______ o           __/ 
             \    \         __/ 
              \____\_______/

# Docker-Django-WSGI
Simple docker  container for django in wsgi


## Building

```
docker build -t django_image .
```

## Running

```
docker run -d -v /local/path/to/app:/var/www/html/client -v /var/log/docks/django:/var/log/httpd -p 80:80 --name web django_image
```

## Sample apache proxing

```
<VirtualHost *:80>
  ServerAlias host.com
  ServerAlias www.host.com
  ServerName www.host.com

  ProxyPass / http://XXX.XXX.XXX.XXX:8282/
  ProxyPassReverse / http://XXX.XXX.XXX.XXX:8282/
  RequestHeader set X-Forwarded-Port 80

  RewriteEngine On
  RewriteCond %{HTTP_HOST} !^www\.
  RewriteRule ^(.*)$ https://www.%{HTTP_HOST}%{REQUEST_URI} [L,R=301]
  RewriteCond %{HTTPS} off
  RewriteRule (.*) https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]
</VirtualHost>

# SSL

NameVirtualHost *:443

<VirtualHost *:443>
  SSLEngine On
  SSLProtocol all -SSLv2 -SSLv3

  SSLCertificateFile /path/to/the/xxx.crt
  SSLCertificateKeyFile /path/to/the/xxx.key
  SSLCACertificateFile /path/to/the/ca-bundle.crt
  SSLCertificateChainFile /path/to/the/intermediate.crt

  ServerAlias host.com
  ServerAlias www.host.com
  ServerName www.host.com

  RewriteEngine On
  RewriteCond %{HTTP_HOST} !^www\.
  RewriteRule ^(.*)$ https://www.%{HTTP_HOST}%{REQUEST_URI} [L,R=301]

  ProxyPass / http://XXX.XXX.XXX.XXX:8383/
  ProxyPassReverse / http://XXX.XXX.XXX.XXX:8383/
  ProxyPreserveHost On
  RequestHeader set X-Forwarded-Port 80
  RequestHeader set X-Forwarded-Proto https
</VirtualHost>
```
