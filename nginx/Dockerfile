FROM nginx:alpine

RUN mkdir -p /var/log/nginx && \
    rm -f /var/log/nginx/access.log /var/log/nginx/error.log && \
    touch /var/log/nginx/access.log /var/log/nginx/error.log && \
    chown -R nginx:nginx /var/log/nginx && \
    chmod 644 /var/log/nginx/access.log /var/log/nginx/error.log

RUN sed -i 's/access_log \/var\/log\/nginx\/access.log/access_log \/var\/log\/nginx\/access.log combined/g' /etc/nginx/nginx.conf && \
    sed -i 's/error_log \/var\/log\/nginx\/error.log/error_log \/var\/log\/nginx\/error.log warn/g' /etc/nginx/nginx.conf

COPY nginx.conf /etc/nginx/nginx.conf
