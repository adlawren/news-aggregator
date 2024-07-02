# news-aggregator

A RSS feed aggregator

## Docker Setup

Run the following to build & start the application:

```sh
docker compose build
docker compose up
```

## Local Setup

Follow the steps below to run the application locally:

Install the required Ruby & Node versions:

```sh
rbenv install $(cat .ruby-version)
nodenv install $(cat .node-version)
```

Prepare Yarn:

```sh
corepack enable
corepack prepare yarn@stable --activate
```

Install the required Ruby dependencies:

```sh
bundle install
```

Install the required Javascript dependencies:

```sh
yarn install
```

Start the DB container:

```sh
docker compose -f docker-compose.db.yml up
```

Copy the `.env.sample` file to `.env` and adjust the environment variables as needed:

```sh
cp .env.sample .env
```

Initialize the DB:

```sh
bundle exec rails db:prepare
```

Start the Rails server:

```sh
./bin/dev
```

Start the job queue in a separate terminal:

```sh
bundle exec rake solid_queue:start
```

## Basic Auth

To enable HTTP Basic authentication, set the `ADMIN_USERNAME` & `ADMIN_PASSWORD` environment variables
