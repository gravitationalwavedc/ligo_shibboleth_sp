FROM debian:buster

# Update the container and install the required packages
RUN apt-get update
RUN apt-get -y install shibboleth-sp2-common shibboleth-sp2-utils libapache2-mod-shib2 libshibresolver2 python-virtualenv python3 libapache2-mod-wsgi-py3

# Enable mod shibboleth and mod wsgi
RUN a2enmod shib
RUN a2enmod wsgi

# Copy apache config
COPY conf/000-default.conf /etc/apache2/sites-enabled/000-default.conf

# Copy django source
COPY src /src

# Create python virtualenv
RUN virtualenv -p python3 /src/venv

# Activate and install the django requirements
RUN . /src/venv/bin/activate && pip install -r /src/requirements.txt

# Configure shibboleth certificates
COPY certs/selfsignedcert.pem /etc/shibboleth/sp-cert.pem
COPY certs/selfsignedkey.pem /etc/shibboleth/sp-key.pem
RUN chown _shibd:_shibd /etc/shibboleth/sp-key.pem
RUN chmod 0600 /etc/shibboleth/sp-key.pem

COPY certs/login.ligo.org.cert.LIOGOCA.pem.txt /etc/shibboleth/login.ligo.org.cert.LIGOCA.pem
COPY certs/shibboleth2-version3.xml /etc/shibboleth/shibboleth2.xml 
COPY certs/attribute-map-ligo.xml /etc/shibboleth/attribute-map.xml

RUN mkdir -p /var/run/apache2
RUN chown www-data:www-data /var/run/apache2

#RUN chown www-data:www-data -R /src
#RUN chmod 777 -R /src
#RUN chmod 777 -R /tmp

EXPOSE 80
CMD service shibd restart && apachectl -D FOREGROUND
