# AWRVI

[![Stories in Ready](https://badge.waffle.io/gina-alaska/awrvi.svg?label=ready&title=Ready)](http://waffle.io/gina-alaska/awrvi)


## Development Setup

Generate development data

* Run `rails dev:prime`

* Run `rails server` to start the app and navigate to `localhost:9292` to see
running app.

## Customizing site theme

The current theme is built using: http://bootstrap-live-customizer.com/

You will need to load the `theme.less` and `variables.less` file from `themes/test` into the web application to load the current custom theme.

After making changes you'll need to click the `Get bootstrap.css` link and save that over the `app/assets/theme.scss` file.

If any changes were made to the `variables` or the `theme.less` in the theme website then those will need to be exported and saved the the `themes/tests` directory.

## Deploying app

Production deploy of [awrvi.espcor.alaska.edu](http://awrvi.epscor.alaska.edu] on [heroku](http://heroku.com) and managed by [UAF-GINA](http://gina.alaska.edu).  Private documentation at [GINA Wiki/AWRVI](https://wiki.gina.alaska.edu/wiki/AWRVI).

## Contributing

You fixed a bug, or added a new feature? Yippie!

1. Fork the repository on Github
1. Create a named feature branch (like add_component_x)
1. Write you change
1. Write tests for your change (if applicable)
1. Run the tests, ensuring they all pass
1. Submit a Pull Request using Github
1. Contributions of any sort are very welcome!
