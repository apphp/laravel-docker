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
docker-compose up -d --build site
~~~


