
FROM nginx:latest


RUN apt-get update && \
    apt-get install -y certbot python3-certbot-nginx awscli cron && \
    apt-get clean


WORKDIR /usr/share/nginx/html


COPY index.html .
COPY error/404.html .
COPY assets/ ./assets/
COPY images/ ./images/
COPY default.conf /etc/nginx/conf.d/


RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html && \
    chmod 644 /etc/nginx/conf.d/default.conf


RUN mkdir -p /var/www/certbot && \
    chown -R nginx:nginx /var/www/certbot && \
    chmod -R 755 /var/www/certbot


RUN chmod -R 755 /etc/letsencrypt


VOLUME /etc/letsencrypt


EXPOSE 80 443


RUN echo "0 0 * * * /usr/bin/certbot renew --quiet && nginx -s reload" > /etc/cron.d/certbot-renew


CMD ["sh", "-c", "cron && nginx -g 'daemon off;'"]

