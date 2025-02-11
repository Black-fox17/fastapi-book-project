# Use a Python slim image as the base
FROM python:3.12-slim

# Install system dependencies including Nginx
RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy your application code and requirements.txt
COPY . /app

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy your custom Nginx configuration into the container
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 (Nginx will listen here)
EXPOSE 80

# Use a startup script to launch both Nginx and your FastAPI app
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
