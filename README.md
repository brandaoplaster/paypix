# Paypix

A simple gem for pix creation

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add paypix

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install paypix

## Usage

 - Copy **env-example** file to **.env** and inform the token
```
cp env-example .env

source .env
```

 - An example hash that can be used for testing.
 - An attention to the **pix_account_id** that has to be created on the platform

```
data = {
  :payer => {
    :document_number => "682.571.466-09",
    :name => "Luna"
  },
  :additional_info => {
    :last_name => "Carl"
  },
  :charge => {
    :amount  => 10.50,
    :pix_account_id => 90,
    :expire_at => "2023-12-02T10:03:56-03:00",
    :message => "Hello word"
  }
}
```


```ruby
pix = Paypix::Pix.new         # instance a class
pix.create(data)              # Calls the create method which receives a hash
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/brandaoplaster/paypix.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
