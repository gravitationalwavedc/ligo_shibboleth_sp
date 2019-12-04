from debian:buster

# Update the container and install the required packages
run apt-get update
run apt-get -y install shibboleth-sp2-common shibboleth-sp2-utils libapache2-mod-shib2 libshibresolver2 python-virtualenv python3 libapache2-mod-wsgi

# Enable mod shibboleth and mod wsgi
run a2enmod shib
run a2enmod wsgi

# Copy apache config

# Copy django source
copy src /src

# Create python virtualenv
run virtualenv -p python3 /src/venv

# Activate and install the django requirements
run . /src/venv/bin/activate && pip install -r /src/requirements.txt
