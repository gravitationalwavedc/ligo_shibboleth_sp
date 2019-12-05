"""
WSGI config for gwcloud_shibboleth project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/3.0/howto/deployment/wsgi/
"""

import os, sys

sys.path.append('/src')
# adjust the Python version in the line below as needed
#sys.path.append('/var/www/vhosts/mysite/venv/lib/python3.5/site-packages')

from django.core.wsgi import get_wsgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'gwcloud_shibboleth.settings')

application = get_wsgi_application()
