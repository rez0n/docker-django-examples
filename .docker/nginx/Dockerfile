FROM django_app:latest as app_image

# Generate staticfiles bundle
RUN python manage.py collectstatic --noinput

FROM nginx:alpine

# Copy staticfiles bundle to the image
COPY --from=app_image /app/staticfiles /var/www/static
COPY .docker/nginx/nginx.conf /etc/nginx/conf.d/default.conf