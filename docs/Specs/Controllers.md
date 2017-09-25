# Controllers

## What Do We Test?

For security purposes, we'll always want to think about a few things regarding
every action that can be performed via the API:

* What happens if it's restricted to logged in users and...
  * a valid user is logged in?
  * an invalid (unauthorized) user is logged in?
  * nobody is logged in?

Let's walk through the basic controller actions that will be implemented in an
API.

### Create

When you need to save a new instance of an object in the database, you'll need
a `create` method.  What will you want to ensure works for this?

* What happens when you provide...
  * valid inputs?
  * invalid inputs?

This can include checking that the expected messages are returned to the
client, as well as ensuring that the instance of the model gets saved to the
database.

### Read

When you need to read data from the database, you'll have a `read` method.  
What will you want to ensure works for this?

* What happens when requested information...
  * is found?
  * can't be found?

This can include ensuring that the expected payload is returned to the client,
and that the format of the response is as expected.  Also, checking that the
proper response in the event of an error is given.

### Update

* What happens when the requested object is found and...
  * you provide valid inputs?
  * you provide invalid inputs?

This is similar to the `create` method, except you can also check what happens
when the object is not found.  You'll also want to ensure that the selected
instance is updated as expected when inputs are valid.

### Destroy

* What happens when the requested object is found and...
  * it gets destroyed?
  * an error occurs in the destroy procedure?

This is similar to the `update` method, except you'll want to ensure that the
selected instance has been removed from the database.

## Extra Notes

This guide is by no means an extensive/exhaustive list of what gets tested for
each controller action, but should serve as a bare-minimum set of scenarios to
address in your specs.
