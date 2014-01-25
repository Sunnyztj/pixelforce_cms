# PixelforceCms

TODO: Write a gem description

## Create a new project

    rails _3.2.16_ new [name] -d mysql

## Installation

Add this line to your application's Gemfile:

    gem 'pixelforce_cms'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pixelforce_cms

## Usage

Generate templates

    $ rails g pixelforce_cms:install

There are 3 options you can customise, assets, controllers, and config. For example if you don't want to generate config settings you can

    $ rails g pixelforce_cms:install --skip-config

Add a new admin controller

    $ rails g pixelforce_cms:controller [name]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
