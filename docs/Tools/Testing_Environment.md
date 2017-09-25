# Testing Environment

## Guard

[Guard](https://github.com/guard/guard) automates things.  You're a developer,
you understand why we would use this.

It makes TDD much more approachable by running specs every time something in
the code base changes.  The less you have to think about re-running specs, the
more likely it is you'll catch a bug before a commit.

## Database Cleaner

[Database Cleaner](https://github.com/DatabaseCleaner/database_cleaner)
simplifies the process of ensuring that our database is cleaned between each
spec that gets run.  If we were to leave the database untouched between tests,
we could build up residue that would make it harder to track down bugs after
running a full suite of specs.

## Faker

In a lot of cases, we'll want to generate random data to either seed the
database or to use as an attribute on one of our models.  
[Faker](https://github.com/stympy/faker) makes this easy.

## RSpec

We're using [RSpec](http://rspec.info/) because it is designed to make our
tests read more like plain English so that after writing a good solid set of
specs for our objects, we shouldn't have to spend too much time documenting
their intended use or constraints.

## Shoulda-Matchers

We use [Shoulda-Matchers](https://github.com/thoughtbot/shoulda-matchers) to
simplify some commonly tested constraints.  It's used purely for the syntax
sugar.

## Factory Girl

We like to use factories instead of fixtures because they make it more clear
where an instance of a model in a spec is coming from.  It also simplifies the
process of updating test data when a column is added to or removed from a
model.  [Factory Girl](https://github.com/thoughtbot/factory_girl_rails) is a
robust solution for creating factories in lieu of fixtures.
