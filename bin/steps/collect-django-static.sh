#!/usr/bin/env bash


if [ -f manage.py ]; then
  put-steps "Collecting Django static files."
  python manage.py collectstatic --link --noinput
fi
