#!/bin/sh
set -e


echo "Applying database migrations..."
python manage.py migrate


exec "$@"