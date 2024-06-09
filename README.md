# news-aggregator

A RSS feed aggregator

## Setup

Install the require Ruby & Node versions:

```sh
rbenv install $(cat .ruby-version)
nodenv install $(cat .node-version)
```

Install Yarn:

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

Start the Rails server:

```sh
bundle exec rails s
```
