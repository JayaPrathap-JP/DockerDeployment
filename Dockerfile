# Use the official Nginx image as a base
FROM nginx:latest

# Copy the HTML file into the Nginx HTML directory
COPY index.html /usr/share/nginx/html/

# Copy the custom Nginx configuration file
COPY default.conf /etc/nginx/conf.d/

# Expose port 80 to be accessible
EXPOSE 80
