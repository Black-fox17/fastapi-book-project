#!/bin/bash
# Start Nginx in the background
service nginx start

# Start FastAPI with Uvicorn listening on 127.0.0.1:8000
exec uvicorn main:app --host 127.0.0.1 --port 8000
