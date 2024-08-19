"""
WSGI config for voltro_pay project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/5.0/howto/deployment/wsgi/
"""

import os

from django.core.wsgi import get_wsgi_application
import newrelic.agent
from django.conf import settings


os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'voltro_pay.settings')

NEW_RELIC_PATH = os.path.join(settings.BASE_DIR, "newrelic.ini")
print(NEW_RELIC_PATH)
newrelic.agent.initialize(config_file=NEW_RELIC_PATH, environment="development")

app = get_wsgi_application()
application = newrelic.agent.WSGIApplicationWrapper(app)
