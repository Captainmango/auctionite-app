# README
[![Rails Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop-rails)[![Rails Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rails.rubystyle.guide) [![CI](https://github.com/Captainmango/auctionite-app/actions/workflows/ci.yml/badge.svg)](https://github.com/Captainmango/auctionite-app/actions/workflows/ci.yml)
## Auctionite
### Usage
This project uses a Procfile to handle building assets for the application. Make sure the Foreman gem is installed [click here](https://github.com/ddollar/foreman). By Running:
```bash
$ foreman start -f Procfile.dev
```

or

```bash
$ bin/dev
```

The Rails application will start. If the database and/or Redis instance does not exist yet, you will likely see an error. Both are created using Docker Compose. By running:

```bash
$ docker compose up db redis -d
```

The database and Redis instance will be started. Then, once completed, run `rails db:create` to create the database. In test, the project uses SQLite3 rather than Postgres. This is so that we have tests that can be run without the need of a docker container running the DB. The tests execute queue jobs inline so Redis is not a factor either.

Once the database is up and running, bring the database up to latest with the command:
```bash
$ rails db:schema:load
```

We prefer this over the normal `rails db:migrate` as it simply makes the database match the schema file rather than running migrations. This is safer overall and means that all projects start off with the same database without much fuss.

The compose file will also start a Redis server and a Sidekiq worker.
> The compose file is for dev purposes only, so is a bit scuffed.

### Configuration

The app requires a `.env` file to be placed in the root in order to correctly build the configuration for accessing the database. The docker compose file uses this too, so place any vars you need in here. The required ones are:

```
PG_DB_USER=abc
PG_DB_PASSWORD=123
RAILS_ENV=development
EMAIL_USER=test@test.com
EMAIL_PASS=password
```

The PG_DB_* vars can be whatever when running locally as Docker will create the database with those credentials. The Redis instance will be auto-connected to as everything looks for redis running locally. To start the required backing services, use the command `docker compose up db redis -d`

You can also run all the services via Docker. To make sure this works, please set the following envvars in addition to the above

```
PG_DB_HOST=db
REDIS_URL_SIDEKIQ=redis://redis:6379/12
```

These, again, are for dev purposes only and are a bit scuffed. Once set, run `docker compose up` to build the app container and the backing services.

### Emails

The application sends emails. In order for this to work, you will need to provide valid details for the SMTP server (Gmail is used in dev). Google's SMTP is simple to use. One gotcha is the password not working for authentication of the application (plain password auth was stopped in May 2022). Instead, you'll need to generate an `App Password`. Use the search on the `Manage your Google account` screen to find this feature.

### Tests

Running the test suite is done using the `rspec spec` command. If you want to test a specific layer (controller, model, etc) append that to the command:

```bash
$ rspec spec/controllers
```

Any folder name can be run in it's entirety or a specifc file. If you want to run a specific test, follow the path with the line number and the closest spec to that number will be run.

```bash
$ respec spec/path/to/file:42
```
