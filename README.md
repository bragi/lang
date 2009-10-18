Lang
====

Lang is a computer language that is:

*   fully object-oriented
*   based on prototypes (rather than class hierarchy)
*   based on message passing (every invocation is a message)

Lang does not have any language structures, there are only messages sent to objects. Message may have some arguments and it's up to receiver to decide if they want to evaluate those arguments. This makes it possible to implement `if()`, `for()` and other constructs known from other languages directly within the language.

Lang gives some syntactic sugar for common operations to make sure you do not waste too much of `()`.

Status
------

This is a first public release of Lang. It doesn't do much: you can run a single file for example:

`build/Debug/lang examples/hello_world.lang`

There is no documentation yet and the only code that is truly working exists in system/boot.lang

Requirements
------------

Lang is developed using Objective-C on Mac OS X 10.6, Xcode 3.2. It uses some Objective-C 2.0 features so probably it can be compiled and run on Snow Leopard only.

Building
--------

Open *lang.xcodeproj*. Make sure that *Active Target* is **Test** and *Active Build Configuration* is **Debug**. Build.

Using
-----

You can only run a single file, there is no error checking right now and if you make a mistake it will probably fall down on it's face with segmentation fault. It's unimpressive and counterproductive. I know. I do not care. Yet.

Contributing
------------

Fork on github, add simple and understandable code with tests and send me a pull request.

Contact
-------

Contact me via e-mail or google talk: bragi@ragnarson.com

