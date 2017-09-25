# API

This API repo was built to create a very simple API in Rails for a web client
to interact with via AJAX calls.  It was designed separately from a UI to
facilitate interaction with multiple clients and allow the client to do one job
well.

## Getting Started

### Software Dependencies

Before you get started working on this project, you'll need a few things
installed on your computer globally.  Below is a list of the software to have
installed.

* [Ruby](https://www.ruby-lang.org/en/)

> It's recommended that you have something along the lines of
> [rbenv](https://github.com/rbenv/rbenv) installed as well to save you from
> nightmares later when working on other projects.  This project in particular
> utilizes the `.ruby-version` file to keep track of which version of Ruby is
> used.

* [Postgresql](https://www.postgresql.org/)

*The easiest way to install and use `Postgres` is via
[Homebrew](https://brew.sh/).*

> It's recommended that if you will be looking at the database while
> developing to download a tool like [pgAdmin](https://www.pgadmin.org/) to
> make this process easier on yourself.

That's pretty much it (for now).  To get started, navigate to the root
directory of this project and run

```
bundle
```

to install all of the necessary Ruby Gems for the project.

### Libraries Used

The main libraries you'll want to get familiar with to work on this project
are:

* [Rails](http://guides.rubyonrails.org/)
* [RSpec](http://rspec.info/)
* [Factory Girl](https://github.com/thoughtbot/factory_girl_rails)
* [Guard](https://github.com/guard/guard)

### TDD

This project is built in Rails, so it already encourages testing and
documentation of methods.  Well tested and well documented API endpoints will
make life much easier for future developers (including future you).  To get the
gist of how to set up specs, poke around in the [spec](spec/) directory.

Tests will run anytime you update application files if you run

```
bundle exec guard
```

and keep the terminal open while you work.

### Database Setup

If you have `Postgres` installed via `Homebrew`, you can run the following
command to start an instance of `Postgres` on your computer (if you didn't
install it via `Homebrew`, sorry but you're on your own!)

```
brew services start postgresql
```

After ensuring `Postgres` is running on your machine, you can run

```
rails db:create
```

to create the API databases locally for `development` and `test` environments.

Once the databases are created on your machine, you'll need to initialize them
with the appropriate schema and data.  To load the latest version of the
database schema (instead of running each individual migration), run

```
rails db:schema:load
```

If you'd like to run each migration individually, run

```
rails db:migrate
```

Finally, to load in seed data for development and testing purposes, run

```
rails db:seed
```

### Development

Run

```
rails s
```

to fire up a development server.  If you want to see how a UI interacts with
the API, you'll need to point traffic from it to `localhost:3000/`.

### Detailed Documentation

If you're curious about how to do anything or the reasons behind choices made
in developing this project, check out the provided
[documentation](docs/Welcome.md)!
