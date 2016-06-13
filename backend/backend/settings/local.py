from .base import *

# Database
# https://docs.djangoproject.com/en/1.9/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'fullstack',
        'USER': 'vagrant',
        'PASSWORD': '!qwerty1',
        'HOST': '10.10.10.10',
        'PORT': '',  # Empty string for default (5432)
    }
}
