# Larahost
[![Build Status](https://travis-ci.org/ankitjain28may/larahost.svg?branch=master)](https://travis-ci.org/ankitjain28may/larahost)
[![Latest Stable Version](https://poser.pugx.org/ankitjain28may/larahost/v/stable)](https://packagist.org/packages/ankitjain28may/larahost)
[![Packagist](https://img.shields.io/packagist/dt/ankitjain28may/larahost.svg?style=flat-square)](https://packagist.org/packages/ankitjain28may/larahost)


Larahost is the extended plugin written over the `laravel/installer` plugin to set up the nginx virtualhost for the application automatically while installing.

## Installation

It requires nginx to be installed in the system.

1. First, download the Larahost installer using Composer:

    ```shell
        composer global require ankitjain28may/larahost
    ```

2. Download the nginx configuration and put it in the nginx virtualhosts folder according to OS. Make necessary changes in the file related to port and PHP FastCGI configuration.

    For example- It is `/usr/local/etc/nginx/servers/` for Mac.

    ```shell
        cd /usr/local/etc/nginx/servers/
        curl https://raw.githubusercontent.com/ankitjain28may/larahost/master/nginx_conf/example.conf -O
    ```

3. Export these variables in $PATH.

    ```shell
        export NGINX_EXAMPLE_FILE='/usr/local/etc/nginx/servers/example.conf'
        export NGINX_DEST='/usr/local/etc/nginx/servers/'
    ```

4. Once everything is setup, the `larahost` new command will create a fresh Laravel installation in the directory you specify.

    ```shell
        larahost new blog
    ```

 ## Contribute

>Feel free to contribute

## License

>Copyright (c) 2019 Ankit Jain - Released under the MIT License
