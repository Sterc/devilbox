# Devilbox local development environment
Based on https://github.com/cytopia/devilbox

## 1. Installation
Requires docker (https://docs.docker.com/get-started/)

1. Clone this repository to your local machine, for example in `~/development/devilbox`
2. Create .env file based on env-example file: `cp env-example .env`
3. Make the following adjustments inside the .env file
- `TLD_SUFFIX` > Set this to your own suffix, for example `joeke`
- `NEW_UID` > Find the UID with command `id -u`
- `NEW_GID` > Find the GID with command `id -g`
- `TIMEZONE=CET`
- `HOST_PATH_HTTPD_DATADIR` > This is the path where your projects are stored, for example `~/development/www`
- `HTTPD_DOCROOT_DIR=webroot` > The public/webroot folder inside the project folders
- `HTTPD_TEMPLATE_DIR=.docker/devilbox` > When using a custom nginx.yml config for a project, it's stored here
- `MYSQL_ROOT_PASSWORD=root`
4. Rename `nginx.yml-sterc` inside the `cfg/vhost-gen/` folder to `nginx.yml`. This is the base nginx config every project uses, and is modified to work with MODX. For a custom nginx config for a specific project, see chapter 6 below.

## 2. Creating projects
If you create a new folder inside your `HOST_PATH_HTTPD_DATADIR` it will automatically become accessible as a local domain.
Preferably use the website domain as the folder name when creating the project folder, for example:
`git clone git@bitbucket.org:sterc/sterc.git sterc.com`
This will make the local site available as `https://sterc.com.[suffix]`, and an SSL certificate is auto generated for that domain.

## 3. Usage
Start the docker containers by running `docker-compose up -d` inside your devilbox folder.
This will start all containers defined in your `docker-compose.yml` file.
You can also start selected containers with `docker-compose up -d php mysql httpd`.

## 4. Running CLI scripts (npm/composer)
Running npm or composer scripts can be done from within the PHP container(s). Access the main PHP container by running:
`./shell.sh`
or
`docker-compose exec --user devilbox php bash -l` > where 'php' is the name of the container you want to access.
This will take you to the container shell, where npm, nvm and composer are pre-installed and ready to use.

### 5. Using SSL / HTTPS
Every project has as an auto-generated SSL certificate for the local domain (`[project-folder].[suffix]`).
To be able to use this the browser/OS has to have the Devilbox certificate authority added.
More info here: https://devilbox.readthedocs.io/en/latest/intermediate/setup-valid-https.html

## 6. Custom nginx configs
When you want to use a custom nginx config for a project, this can be added as `.docker/devilbox/nginx.yml` inside your project folder. 
There are examples of this in various Sterc projects.

## 7. Additional PHP versions
The default PHP container is defined by the `PHP_SERVER` value in your `.env` file. 
You can add additional PHP versions by adding them as services inside the docker-compose.yml file, which will make them available as separate containers.
An example PHP 7.4 container is already added in the default docker-compose.yml file. If you want to use a different PHP for a specific project, make sure to add an nginx.yml config file inside your project (see chapter 6 above).

## 8. Overriding php.ini settings
In the `cfg/php-ini-8.1` folder (or whatever version you're using) you can add a `.ini` file where the default php.ini settings can be overridden.
For example:
```
max_execution_time = 300
memory_limit = 2048M
pcre.backtrack_limit = 10000000
pcre.jit = 0
```
