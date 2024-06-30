# news-aggregator

A RSS feed aggregator

## Setup

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

Start the Docker containers:

```sh
docker compose up
```

Initialize the DB:

```sh
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed
```

Start the job queue:

```sh
bundle exec rake solid_queue:start
```

Start the Rails server:

```sh
./bin/dev
```

## Basic Auth

To enable HTTP Basic authentication, set `ADMIN_USERNAME` & `ADMIN_PASSWORD` in the `.env` file, for example:

```sh
ADMIN_USERNAME=admin
ADMIN_PASSWORD=password
```
