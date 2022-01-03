# Laravel Docker

A pretty simple Docker Compose workflow that sets up your own network of containers for local Laravel development. 

## Usage

To get started, make sure you have Docker installed on your system, and then clone this repository:
- [Docker for Windows](https://docs.docker.com/desktop/windows/install/)
- [Docker for Mac](https://docs.docker.com/desktop/mac/install/)
- [Docker for Other](https://docs.docker.com/compose/install/)


To start working with docker do following 

1. Open a terminal and navigate to the directory you cloned this
   or copy `docker/` directory and `docker-composer.yml` to your current project and navigate to there.

2. Rename everywhere in files `myapp` name with the name you prefer for your application.

3. Run following command to spin up the containers for the web server:

~~~yaml
docker-compose up --build -d
~~~

After building containers you may up them by following command:
~~~yaml
docker-compose up -d
~~~
or down with 
~~~yaml
docker-compose down
~~~


After successful building your website will be accessible via:
~~~
http://localhost:8081
~~~

## Schema
~~~
   ___________     ___________     ___________     ___________	
   |         |     |         |     |         |     |         |
   |  NGINX  | --→ | PHP-FPM |     | PHP-CLI |     |  REDIS  |  
   |         |	   |         |     |         |     |         |
   -----------	   -----------     -----------     -----------
        |               |               |
        ↓               ↓               ↓           
   ____________   ______________________________
   |  Static  |   |                            |
   | Content  |   |           CODE             |
   | CSS,JS.. |   |                            |
   ------------   ------------------------------
~~~

## Environment Configuration

Make sure you created following keys in your `.env` file:
~~~yaml
DB_DATABASE=your-db
DB_USERNAME=your-db-username
DB_PASSWORD=your-db-password
~~~


## Persistent MySQL Storage

When you bring down the Docker network, your MySQL data will be removed after the containers are destroyed. This is a default behaviour of Docker containers. 
If you would like to have persistent data that remains after bringing containers down and back up, do the following:

1. Create a `./storage/docker/mysql` folder in your Laravel project root.
2. Under the mysql service in your `docker-compose.yml` file, add the following lines:

```
volumes:
  - ./storage/docker/mysql:/var/lib/mysql
```


## Working with PHP-CLI

#### Migrations, Seeders and Import DB
After successful building and running docker containers you may run migrations and seeders.
To perform these operations, simply type in your terminal and execute following commands:

```
docker-compose run --rm php-cli php artisan migrate
docker-compose run --rm php-cli php artisan db:seed
```

#### Working with Composer
To install/remove new package run following commands:
```
docker-compose run --rm php-cli composer require predis/predis
```

Other commands you would like to run:
```
docker-compose run --rm php-cli composer --version
docker-compose run --rm php-cli composer dump-autoload
docker-compose run --rm php-cli composer test ExampleTest
```

#### Working with PHP & Artisan
Example of commands you would like to run:
```
docker-compose run --rm php-cli php -v
docker-compose run --rm php-cli php artisan migrate
docker-compose run --rm php-cli php artisan db:seed
docker-compose run --rm php-cli php artisan optimize:clear
docker-compose run --rm php-cli php artisan schedule:run
```

#### Working with Git
```
docker-compose run --rm php-cli git branch
docker-compose run --rm php-cli git pull
 ```

#### Working with Redis
```
composer require predis/predis
docker exec -it redis bash
ping
redis-cli
keys *
set name John
get name
exit
 ```