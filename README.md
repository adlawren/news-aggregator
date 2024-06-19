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
```

Initialize the assets:

```sh
bundle exec rake assets:precompile
```

Start the job queue:

```sh
bundle exec rake solid_queue:start
```

Start the Rails server:

```sh
./bin/dev
```
