#!/usr/bin/env bash


if [ -f manage.py ]; then
  puts-step "Collecting Django static files."
  python manage.py collectstatic --link --noinput
fi
