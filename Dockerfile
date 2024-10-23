# Use the latest NGINX image as a base
FROM 3b25b682ea82

# Set the working directory
WORKDIR /usr/share/nginx/html

# Copy the necessary files into the image
COPY index.html .
COPY error/404.html .
COPY assets/ ./assets/
COPY images/ ./images/
COPY favicon.ico .
COPY default.conf /etc/nginx/conf.d/

# Set permissions
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html && \
    chmod 644 /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80



