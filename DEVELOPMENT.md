# Development

## Prerequisite

To make developer life easier, Houston comes with a `docker-compose.yml` file
that will setup the database and Houston dependencies needed to run a
development copy.

You will need to have `docker` and `docker-compose` installed on your
system. The Docker website has great guides for
[installing docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce)
and for [installing docker-compose](https://docs.docker.com/compose/install/).

## Running

Once you have `docker` and `docker-compose` installed, simply run
`docker-compose up` and you will get a running developer instance of Houston
server. You can view the website at [`localhost:4000`](http://localhost:4000).

**NOTE** If you make any changes to elixir dependencies or node dependencies,
you will need to rebuild the Houston image with `docker-compose build houston`.
Everything else should be hot code reloaded.

### Helpful tips

The postgresql username and password are the default docker ones
(`postgres:postgres`).

Mongodb requires the same version cli as the server. To keep this simple, you
can use `docker run --network host -it mongo:3.2 mongo` to access the mongo cli.

## Testing

Just like development, Houston can be tested with `docker` and `docker-compose`.
Simply run `docker-compose run houston test`. This will start all the
dependencies, but instead of running the server, run our tests.

## Deploying

For deployment, we have a different `Dockerfile` called `Dockerfile-production`.
This image will be built with our code in production, so it will not include
hot code reloading, or some debug log output. All you have to do is run
`docker build -t houston -f Dockerfile-production .`
