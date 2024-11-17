#!/bin/sh

while ! nc -z postgres 5432; do
  sleep 1
done

python manage.py migrate

python manage.py createsuperuser --noinput --username $DJANGO_SUPERUSER_USERNAME --email $DJANGO_SUPERUSER_EMAIL || true

python manage.py collectstatic --noinput

gunicorn --bind 0.0.0.0:8000 my_project.wsgi:application
