# README
[![Rails Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop-rails)
[![Rails Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rails.rubystyle.guide)

[![CI](https://github.com/Captainmango/auctionite-app/actions/workflows/ci.yml/badge.svg)](https://github.com/Captainmango/auctionite-app/actions/workflows/ci.yml)
## Auctionite

### Usage
This project uses a Docker Compose to handle building assets and running the application. Make sure the Docker and Docker Compose are installed and configured correctly. By Running:

```bash
$ docker compose up -d
```

or

```bash
$ rake docker:run
```

The Rails application will start. This will start all the working parts of the app. They are already networked together. However, you may see an error if you do not have a `.env` file in the root of the project.

To stop the project, use:

```bash
$ docker compose down
```

or

```bash
$ rake docker:stop
```

### Configuration

The app requires a `.env` file to be placed in the root in order to correctly build the configuration for accessing the database. The docker compose file uses this too, so place any vars you need in here. The required ones are:

```
PG_DB_USER=abc
PG_DB_PASSWORD=123
RAILS_ENV=development
EMAIL_USER=test@test.com
EMAIL_PASS=password
PG_DB_HOST=db
REDIS_URL_SIDEKIQ=redis://redis:6379/1
```

The PG_DB_* vars can be whatever as Docker will create the database with those credentials.

### Database

If this is a fresh set up, run `rails db:create` to create the database. In test, the project uses SQLite3 rather than Postgres. This is so that we have tests that can be run without the need of Docker containers. The tests execute queue jobs inline so Redis is not a factor either.

Once the database is up and running, bring the database up to latest with the command:

```bash
$ rails db:schema:load
```

We prefer this over the normal `rails db:migrate` as it simply makes the database match the schema file rather than running migrations. This is safer overall and means that all projects start off with the same database without much fuss.

### Emails

The application sends emails. In order for this to work, you will need to provide valid details for the SMTP server (Gmail is used in dev). Google's SMTP is simple to use. One gotcha is the password not working for authentication of the application (plain password auth was stopped in May 2022). Instead, you'll need to generate an `App Password`. Use the search on the `Manage your Google account` screen to find this feature.

In `development` all emails are redirected to a specific email. Please see `./config/initializers/email_testing.rb` for the email and change it to whatever is needed. No need for clever mail traps here!!

### Debugging

As the application runs in containers, you will need to use `docker attach app_web` to connect to the running web container.

> N.B. a key gotcha is stdin not being streamed. Only new writes to stdin are picked up. Run this before entering a debug session

_Use `CTRL+P CTRL+Q` to quit an attached tty_

### Tests

Running the test suite is done using the `rspec spec` command. If you want to test a specific layer (controller, model, etc) append that to the command:

```bash
$ rspec spec/controllers
```

Any folder name can be run in it's entirety or a specifc file. If you want to run a specific test, follow the path with the line number and the closest spec to that number will be run.

```bash
$ respec spec/path/to/file:42
```

### Image Registry

Images for deployment are stored in Docker. By running the command:

```bash
$ rake docker:build_and_store
```

A new version of the app image will be built and stored in the registry. Check the project.json file for the current version and image name. The registry is private.
