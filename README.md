# Fixedwidth

Bare bones fixed width data processing. Transform fixed width files into CSV or Ruby Hashes.

## Installation

Add this line to your application's Gemfile:

    gem 'fixedwidth'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fixedwidth

## Usage

Arguments taken are:

  file        - path to the fixed width file
  start       - a string of positions postitions
  stop        - a string of stop positions
  header      - a string of column names
  delimiter   - data delimiter of choice, defaults to comma

Note that the stop positions are the column positions in the actual file. The offset is calculated by the Gem so you don't have to do it.

Example

```ruby
# ./contacts.txt
# John    Smith   john@example.com                1-888-555-6666
# Michele O'Reileymichele@example.com             1-333-321-8765

Fixedwidth.parse(file: 'contacts.txt', start:  '1,9,17,44,46', stop: '8,16,36,45,63', header: 'first,last,email,blank,phone', delimiter: ",") do |line|
  puts line.to_hash
  # => { first: "John", last: "Smith", email: "john@example.com", blank: "", phone: "1-888-555-6666" }
  puts line.to_csv
  # => "John,Smith,john@example.com,,1-888-555-6666"

  # ...rest of loop.
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
