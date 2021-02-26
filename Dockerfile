FROM nginx:1.19-alpine

ENV AUTH_BASIC_TITLE="Restricted Area"

COPY conf.d /etc/nginx/conf.d
COPY /entrypoint.sh /entrypoint.sh

RUN apk add apache2-utils \
    && chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["nginx", "-g", "daemon off;"]
