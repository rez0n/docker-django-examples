FROM python:3.9-alpine3.16

WORKDIR /app

ENV PYTHONUNBUFFERED=1 \
    PYTHONFAULTHANDLER=1 \
    PYTHONHASHSEED=random \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100

RUN apk update \
    && apk add --no-cache --virtual .build-deps python3-dev libffi-dev gcc musl-dev make libevent-dev build-base mariadb-dev \
    && pip install --no-cache-dir gunicorn gevent mysqlclient \
    && apk del .build-deps

# Copy app source
COPY . .

# Install requirements
RUN pip install --no-cache-dir -r requirements.txt

# Copy and enable entrypoint.sh
COPY .docker/app/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE 8000
# 'app' in the 'app.wsgi:application' - it is directory name where placed settings.py file
CMD ["gunicorn", "--bind", ":8000", "--workers", "3", "--error-logfile", "-", "--access-logfile", "-", "app.wsgi:application"]
