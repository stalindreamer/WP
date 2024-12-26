# Use an official WordPress image as the base
FROM wordpress:php8.3-fpm #wordpress:latest

# Copy your WordPress code into the container
COPY . /var/www/html/

# Expose port 80 (HTTP)
EXPOSE 80
