#!/bin/bash
set -e

# Ensure PORT is set; default to 80 if not.
if [ -z "$PORT" ]; then
    echo "PORT is not set. Defaulting to 80."
    PORT=80
fi

# Substitute the PORT environment variable in the Nginx configuration template.
envsubst '$PORT' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Test the generated Nginx configuration for syntax errors.
nginx -t

# Start Nginx.
service nginx start

# Start Uvicorn to serve your FastAPI app internally on port 8000.
exec uvicorn main:app --host 127.0.0.1 --port 8000
