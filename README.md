# Hcipher

Ruby gem for encrypting and decrypting text using hill cipher algorithm

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hcipher'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install hcipher

## Usage

Run rake task to generate key. Input an integer in place of n, this will return an n x n matrix that has been converted to a string.

    $ rake hcipher:generate_key[n]

Place hcipher key inside your application, for example in the credentials.

Run this script to encrypt your text.

```ruby
Hcipher::Cipher.encrypt(text, key)
```

Run this script to decrypt your encrypted text.

```ruby
Hcipher::Cipher.decrypt(encrypted_text, key)
```

If you need an example application, see this [simple application](https://github.com/arssy/hcipher_apptest)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/arssy/hcipher. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/arssy/hcipher/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Hcipher project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/arssy/hcipher/blob/master/CODE_OF_CONDUCT.md).
