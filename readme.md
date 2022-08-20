This repository contains multiple docker-compose files because multi-stage build used.

Nginx image depends on application image because app image used to extract staticfiles during nginx image to reduce build time.

## Build
```bash
docker-compose -f docker-compose-app.yml build
docker-compose -f docker-compose-nginx.yml build
```

## Run
```bash
docker-compose up
```