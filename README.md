# README
[![Rails Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop-rails)[![Rails Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rails.rubystyle.guide) [![Ruby on Rails CI](https://github.com/Captainmango/auctionite-app/actions/workflows/rubyonrails.yml/badge.svg)](https://github.com/Captainmango/auctionite-app/actions/workflows/rubyonrails.yml)

## Auctionite
### Usage
This project uses a Procfile to handle start up of services for the application. Make sure the Foreman gem is installed [click here](https://github.com/ddollar/foreman). By Running:
```bash
$ foreman start -f Procfile.dev
```

The database and the Rails application will start. If the database does not exist yet, you will likely see an error. The DB is created using Docker Compose. By running:

```bash
$ docker compose -f compose-pg-only.yml up -d
```

The database will be built. Then, once completed, run `rails db:create` to create the database. In test, the project uses SQLite3 rather than Postgres. This is so that we have tests that can be run without the need of a docker container running the DB.

Once the database is up and running, bring the database up to latest with the command:
```bash
$ rails db:schema:load
```

We prefer this over the normal `rails db:migrate` as it simply makes the database match the schema file rather than running migrations. This is safer overall and means that all projects start off with the same database without much fuss.

### Configuration

The app requires a `.env` file to be placed in the root in order to correctly build the configuration for accessing the database. The docker compose file uses this too, so place any vars you need in here. The required ones are:

```
PG_DB_USER=abc
PG_DB_PASSWORD=123
```

These can be whatever when running locally as Docker will create the database with those credentials.

### Tests

Running the test suite is done using the `rspec spec` command. If you want to test a specific layer (controller, model, etc) append that to the command:

```bash
$ rspec spec/controllers
```

Any folder name can be run in it's entirety or a specifc file. If you want to run a specific test, follow the path with the line number and the closest spec to that number will be run.

```bash
$ respec spec/path/to/file:42
```
