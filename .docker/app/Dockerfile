FROM python:3.9-slim

ENV PYTHONUNBUFFERED=1 \
    PYTHONFAULTHANDLER=1 \
    PYTHONHASHSEED=random \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100

# Install dependencies
RUN apt update && apt install -y \
    # mysqlclient dependencies
    default-libmysqlclient-dev gcc \
    # Clean apt cache
    && apt clean && rm -rf /var/lib/apt/lists/*

# Copy app source
WORKDIR /app
COPY . .

# Install requirements
RUN pip install --no-cache-dir gunicorn gevent
RUN pip install --no-cache-dir -r requirements.txt

# Copy and enable
COPY .docker/app/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE 8000
# 'app' in the 'app.wsgi:application' - it is directory name where placed settings.py file
CMD ["gunicorn", "--bind", ":8000", "--workers", "3", "--error-logfile", "-", "--access-logfile", "-", "app.wsgi:application"]
