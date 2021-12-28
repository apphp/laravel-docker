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

After successful building your website will be accessible via:
~~~
http://localhost:8081
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