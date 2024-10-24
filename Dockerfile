# Use the latest NGINX image as a base
FROM nginx:latest

# Install Certbot and its Nginx plugin
RUN apt-get update && \
    apt-get install -y certbot python3-certbot-nginx awscli cron && \
    apt-get clean

# Set working directory
WORKDIR /usr/share/nginx/html

# Copy the necessary files into the image
COPY index.html .
COPY error/404.html .
COPY assets/ ./assets/
COPY images/ ./images/
COPY default.conf /etc/nginx/conf.d/

# Change ownership and permissions of the HTML directory and files
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html && \
    chmod 644 /etc/nginx/conf.d/default.conf

# Create a volume for storing Let's Encrypt certificates
VOLUME /etc/letsencrypt

# Expose port 80 and 443 for HTTP and HTTPS
EXPOSE 80 443

# Add a cron job to renew SSL certificates daily
RUN echo "0 0 * * * /usr/bin/certbot renew --quiet && nginx -s reload" > /etc/cron.d/certbot-renew

# Run Certbot to obtain SSL certificates and then start Nginx
CMD ["sh", "-c", "if [ ! -f /etc/letsencrypt/live/alchem.in.net/fullchain.pem ]; then certbot --nginx -d alchem.in.net --non-interactive --agree-tos --email jayaprathap1996@gmail.com; fi && nginx -g 'daemon off;'"]
