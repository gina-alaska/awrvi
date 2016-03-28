# AWRVI

[![Stories in Ready](https://badge.waffle.io/gina-alaska/awrvi.svg?label=ready&title=Ready)](http://waffle.io/gina-alaska/awrvi)


## Setup

This project uses [Otto](https://www.ottoproject.io) for a development environment.

* Install otto
* If it's the first time checking this code out
  * `otto compile`
* `otto dev`
* `otto dev ssh`

Now you are able to run your rake tasks to set up the database for development.

An additional rake task has been provided for installing phantomjs, which is used in
integration tests

* Run `rails dev:setup`  to install phantomjs.

Generate development data

* Run `rails dev:prime`

## Contributing

You fixed a bug, or added a new feature? Yippie!

1. Fork the repository on Github
1. Create a named feature branch (like add_component_x)
1. Write you change
1. Write tests for your change (if applicable)
1. Run the tests, ensuring they all pass
1. Submit a Pull Request using Github
1. Contributions of any sort are very welcome!
