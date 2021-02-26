#!/bin/sh

# Create /.htpasswd from env variables if it isn't mounted
if [ ! -f "/.htpasswd" ]; then
    if [ -z "$HTPASSWD_USERNAME" ] || [ -z "$HTPASSWD_PASSWORD" ]; then
        echo "If you don't mount /.htpasswd, you must provide both HTPASSWD_USERNAME and HTPASSWD_PASSWORD" 1>&2
        exit 1
    fi

    echo "Generating /.htpasswd using HTPASSWD_USERNAME and HTPASSWD_PASSWORD..."
    htpasswd -b -c /.htpasswd $HTPASSWD_USERNAME $HTPASSWD_PASSWORD
else
    echo "Using mounted /.htpasswd file"
fi

# Pass variables into nginx config
defined_envs=$(printf '${%s} ' $(env | cut -d= -f1))
envsubst "$defined_envs" < /etc/nginx/conf.d/default.conf > /etc/nginx/conf.d/default.conf.new \
    && rm /etc/nginx/conf.d/default.conf \
    && mv /etc/nginx/conf.d/default.conf.new /etc/nginx/conf.d/default.conf

# Execute entrypoint of nginx image
exec /docker-entrypoint.sh "$@"
