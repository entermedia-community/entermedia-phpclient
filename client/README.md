# PHP Wrapper for the EnterMediaDB API
# PHPunit


## Installation
## This library requires PHP 7.1 or newer with a CURL extension.

    # apt-get install php7 php-curl php-mbstring php-xml
    # apt-get install curl

## Run `composer update` then `composer install`.

    ## alternative composer.phar
    # entermedia-phpclient$ curl -sS https://getcomposer.org/installer | php
    # entermedia-phpclient$ php composer.phar install

## Testing
# Make sure to run `composer update` after any change in libraries.

# Run `runTest.sh`.

# Config file: test/config.json
# Test scripts at: test/EnterMedia/Test/Test.php

# Update Asset:
# test/EnterMedia/Test/TestUpdate.php - takes an array of fields to update, requires the asset_id
