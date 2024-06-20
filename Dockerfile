# Use a smaller base image with Apache and PHP 7.4
FROM php:7.4-apache-buster

# Install dependencies and PHP extensions
RUN apt-get update && \
    apt-get install -yqq --no-install-recommends \
        unzip \
        libzip-dev \
    && docker-php-ext-install pdo_mysql opcache zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Enable AutoProfile for PHP
RUN echo "instana.enable_auto_profile=1" > "/usr/local/etc/php/conf.d/zzz-instana-extras.ini"

# Enable Apache mod_rewrite and status
RUN a2enmod rewrite && a2enmod status

# Copy Apache status configuration file
COPY status.conf /etc/apache2/mods-available/status.conf

# Set working directory
WORKDIR /var/www/html

# Copy application code
COPY html/ /var/www/html

# Install Composer globally
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Install PHP dependencies using Composer
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Adjust permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && rm -rf /var/www/html/var/*

# Expose port 80
EXPOSE 80

# Start Apache in foreground
CMD ["apache2-foreground"]

# #
# # Build the app
# #
# FROM php:7.4-apache

# RUN apt-get update && apt-get install -yqq unzip libzip-dev \
#     && docker-php-ext-install pdo_mysql opcache zip

# # Enable AutoProfile for PHP which is currently opt-in beta
# RUN echo "instana.enable_auto_profile=1" > "/usr/local/etc/php/conf.d/zzz-instana-extras.ini"

# # relax permissions on status
# COPY status.conf /etc/apache2/mods-available/status.conf
# # Enable Apache mod_rewrite and status
# RUN a2enmod rewrite && a2enmod status

# WORKDIR /var/www/html

# COPY html/ /var/www/html

# COPY --from=composer /usr/bin/composer /usr/bin/composer
# RUN composer install

# # This is important. Symfony needs write permissions and we
# # dont know the context in which the container will run, i.e.
# # which user will be forced from the outside so better play
# # safe for this simple demo.
# RUN rm -Rf /var/www/var/*
# RUN chown -R www-data /var/www
# RUN chmod -R 777 /var/www

