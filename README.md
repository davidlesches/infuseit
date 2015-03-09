# Infuser

A cleaner Ruby wrapper for the InfusionSoft API.

This gem is for use with the Infusionsoft OAuth2 API. If you are using the token-based API, see [Nathan Levitt's gem](https://github.com/nateleavitt/infusionsoft), which this gem is based on.

## Philosophy

Infusionsoft has quite the annoying API. One example: field names are not standardized. Another: some API calls require specific arguments in a specific order, others take a hash.

I've gone out of my way to standardize these things behind the scenes in order to provide a cleaner Ruby-esque way of dealing with the API.

## Caveats

I developed this gem as part of a project for a client. It covers companies, contacts, and invoices, but not much else, as that was all the client required. Pull requests are always welcome.

## Installation
1. Add the gem to your gemfile.

```
gem install infuser
```

2. Create an initializer file in your Rails app, with your Infusionsoft API settings:

```ruby
Infuser::Configuration.configure do |config|
  config.api_key    = 'Your-App-API-Key'
  config.api_secret = 'Your-App-API-Secret'
end
```

Within the configuration file above, you can also set the `logger` as well as `retry_count` for how many times a call should be attempted before giving up.

## Usage

This gem is for use with Infusionsoft's *OAuth2* API, not the token-based API.

Use the [omniauth-infusionsoft](https://github.com/l1h3r/omniauth-infusionsoft) gem to allow your users to connect and authorize their accounts, just like you would connect [any other OAuth gem](http://railscasts.com/episodes/360-facebook-authentication).

Once a user authorizes their account, Infusionsoft returns an `access_token`. You use this `access_token` to begin using this Infuser gem.

### Contacts

## Issues
Submit the issue on Github. I handle gems in my spare time, so no promises on when I can look into things. Pull requests appreciated.

## Copyright
Copyright (c) 2014 David Lesches.

Original based on code from [Nathan Levitt's gem](https://github.com/nateleavitt/infusionsoft).

## License
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.