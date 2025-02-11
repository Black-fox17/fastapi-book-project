# Use a slim Python base image.
FROM python:3.12-slim

# Install system dependencies including Nginx.
RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory.
WORKDIR /app

# Copy your application code and dependency file.
COPY . /app

# Install Python dependencies.
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the Nginx configuration template into the container.
COPY nginx.conf.template /etc/nginx/nginx.conf.template

# Copy the entrypoint script and ensure it is executable.
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose the port Render expects.
# Render will supply $PORT at runtime, so we can expose 80 as a default.
EXPOSE 80

# Use the entrypoint script to start the container.
CMD ["/entrypoint.sh"]
