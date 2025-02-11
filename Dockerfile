# Use a slim Python base image.
FROM python:3.12-slim

# Install system dependencies including Nginx and gettext (for envsubst)
RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx \
    gettext \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory.
WORKDIR /app

# Copy your application code and dependency file.
COPY . /app

# Install Python dependencies.
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy your nginx configuration template into the container.
# Ensure your file is named nginx.conf.template in your build context.
COPY nginx.conf.template /etc/nginx/nginx.conf.template

# Copy the entrypoint script and ensure it is executable.
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose the port that Render provides (we assume 80 for example purposes)
EXPOSE 80

# Use the entrypoint script to start the container.
CMD ["/entrypoint.sh"]
