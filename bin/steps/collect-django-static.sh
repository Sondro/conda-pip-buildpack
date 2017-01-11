#!/usr/bin/env bash

set +e

if [ -f manage.py ]; then
  puts-step "Collecting Django static files."
  python manage.py collectstatic --link --noinput
fi

set -e
