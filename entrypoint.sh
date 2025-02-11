#!/bin/bash
set -e

# Replace environment variables in the Nginx configuration template.
envsubst '$PORT' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Start Nginx (it will now listen on 0.0.0.0:$PORT)
service nginx start

# Start Uvicorn to serve your FastAPI app internally on port 8000.
# Note: Uvicorn is bound to 127.0.0.1 so it is only accessible by Nginx.
exec uvicorn main:app --host 127.0.0.1 --port 8000
