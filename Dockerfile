

FROM nginx:latest
WORKDIR /usr/share/nginx/html


COPY index.html .
COPY default.conf /etc/nginx/conf.d/


RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html && \
    chmod 644 /etc/nginx/conf.d/default.conf


EXPOSE 80
