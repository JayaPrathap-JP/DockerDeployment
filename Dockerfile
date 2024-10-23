# Use the latest NGINX image as a base
FROM nginx:latest

# Install necessary packages
RUN apt-get update && \
    apt-get install -y certbot python3-certbot-nginx awscli cron && \
    apt-get clean

# Set the working directory
WORKDIR /usr/share/nginx/html

# Copy the necessary files into the image
COPY index.html .
COPY error/404.html .
COPY assets/ ./assets/
COPY images/ ./images/
COPY default.conf /etc/nginx/conf.d/

# Set permissions
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html && \
    chmod 644 /etc/nginx/conf.d/default.conf

# Create directory for Certbot challenges
RUN mkdir -p /var/www/certbot && \
    chown -R nginx:nginx /var/www/certbot && \
    chmod -R 755 /var/www/certbot

# Define volume for Let's Encrypt certificates
VOLUME /etc/letsencrypt

# Expose ports 80 and 443
EXPOSE 80 443

# Set up cron job for renewing SSL certificates
RUN echo "0 0 * * * /usr/bin/certbot renew --quiet && nginx -s reload" > /etc/cron.d/certbot-renew

# Start cron and NGINX
CMD ["sh", "-c", "cron && nginx -g 'daemon off;'"]
