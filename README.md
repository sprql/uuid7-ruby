# UUID7

Implementation of [UUIDv7](https://github.com/uuid6/uuid6-ietf-draft) in [Ruby](https://www.ruby-lang.org/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'uuid7'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install uuid7

## Usage

```
UUID7.generate
```

## Performance

| Library | Iterations/second     |
|--------:|----------------------:|
|  UUIDv7 | 412.324k (± 0.5%) i/s |
|  UUIDv4 | 483.110k (± 0.7%) i/s |
|    ULID | 156.675k (± 0.7%) i/s |
|   KSUID | 108.075k (± 0.9%) i/s |

See [examples](https://github.com/sprql/uuid7-ruby/examples/bench.rb)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sprql/uuid7-ruby.
