# Environment Variables

## Getting Started

You'll want to run

```
bundle exec figaro install
```

to create the `application.yml` file where environment variables are stored
locally for development. This file is ignored by `Git` (as it should be), so
you'll need to get a copy of the file from another dev working on the project
in order to get up and running.

## Why Figaro?

[Figaro](https://github.com/laserlemon/figaro) makes setting up environment
variables incredibly easy.  We can use a simple `application.yml` file to keep
track of environment variables in local development so that we're storing
sensitive credentials outside of application code from the get-go.
