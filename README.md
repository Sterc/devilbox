# Devilbox local development environment
Based on https://github.com/cytopia/devilbox

## Installation
Requires docker (https://docs.docker.com/get-started/)

1. Clone this repository to your local machine, for example in `~/development/devilbox`
2. Create .env file based on env-example file: `cp env-example .env`
3. Make the following adjustments inside the .env file
- `TLD_SUFFIX` > Set this to your own suffix, for example `joeke`
- `NEW_UID` > Find the UID with command `id -u`
- `NEW_GID` > Find the GID with command `id -g`
- `TIMEZONE=CEST`
- `HOST_PATH_HTTPD_DATADIR` > This is the path where your projects are stored, for example `~/development/www`
- `HTTPD_DOCROOT_DIR=webroot` > The public/webroot folder inside the project folders
- `HTTPD_TEMPLATE_DIR=.docker/devilbox` > When using a custom nginx.yml config for a project, it's stored here
- `MYSQL_ROOT_PASSWORD=root`

## Creating projects
If you create a new folder inside your `HOST_PATH_HTTPD_DATADIR` it will automatically become accessible as a local domain.
Preferably use the website domain as the folder name when creating the project folder, for example:
`git clone git@bitbucket.org:sterc/sterc.git sterc.com`
This will make the local site available as `https://sterc.com.<suffix>`, and an SSL certificate is auto generated for that domain.

## Usage
Start the docker containers by running `docker-compose up -d` inside your devilbox folder.
This will start all containers defined in your `docker-compose.yml` file.
You can also start selected containers with `docker-compose up -d php mysql httpd`.

## CLI (npm/composer)
TODO

### Using SSL / HTTPS
Every project has as an auto-generated SSL certificate for the local domain (<project-folder>.<suffix>).
To be able to use this the browser/OS has to have the Devilbox certificate authority added.
More info here: https://devilbox.readthedocs.io/en/latest/intermediate/setup-valid-https.html

## Custom nginx configs
TODO

## Additional PHP versions
TODO

# TODO
- set global nginx config in `vhost-gen/nginx.yml` (correct for MODX, add www domain) > https://devilbox.readthedocs.io/en/latest/vhost-gen/customize-all-virtual-hosts-globally.html#vhost-gen-customize-all-virtual-hosts-globally
- comment out unused containers in docker-compose.yml
- add example for adding custom nginx config
- add extra php container for 7.4 in docker-compose.yml
