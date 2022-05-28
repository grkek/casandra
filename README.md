# Casandra

A drop-in shard for case aware JSON serialization.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     casandra:
       github: grkek/casandra
   ```

2. Run `shards install`

## Usage

```crystal
require "casandra"

class User
  include JSON::Serializable

  property first_name : String
  property last_name : String

  def initialize(@first_name : String, @last_name : String)
  end
end

puts User.new(first_name: "Jane", last_name: "Doe").to_json case: :camel # {"firstName":"Jane","lastName":"Doe"}
pp User.from_json(%({"firstName": "John", "lastName": "Doe"}), case: :camel) # <User:0x10db93e20 @first_name="John", @last_name="Doe">
```


## Contributors

- [Giorgi Kavrelishvili](https://github.com/grkek)
