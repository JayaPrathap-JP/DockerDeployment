
# Use the official Nginx image as a base
FROM nginx:latest

# Set working directory
WORKDIR /usr/share/nginx/html

# Copy the HTML file into the Nginx HTML directory
COPY index.html .

# Copy the custom Nginx configuration file
COPY default.conf /etc/nginx/conf.d/

# Change ownership and permissions of the HTML directory and files
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html && \
    chmod 644 /etc/nginx/conf.d/default.conf

# Expose port 80 to be accessible
EXPOSE 80
