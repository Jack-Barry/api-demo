# Models

## What Do We Test?

Let's walk through some of the things we'd want to think about testing
regarding our models.

### Attributes

Every object has different attributes to set, and when possible it's always
good practice to screen for valid data before saving it.  We want to check that
each attribute is properly responding to invalid data.  Some things you might
look for include:

* Error messages are properly returned
* If the proper data type is set for the attribute

### Lifecycle

Think about what should happen throughout the lifecycle of an object, and what
would signal that it's doing what is expected.

#### Initiation and Alteration

When an instance of the object is created or updated does it need to...

* transform any of the incoming parameters/attributes?
* interact with any other objects?

#### Destruction

When an instance of the object is destroyed/deleted, does it need to...

* transform references made to it from other locations?
* remove any related records?

## Extra Notes

This guide is by no means an extensive/exhaustive list of what gets tested for
each controller action, but should serve as a bare-minimum set of scenarios to
address in your specs.
