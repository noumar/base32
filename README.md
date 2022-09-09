# ARCHIVED!!! See https://github.com/philnash/base32 or https://github.com/didactic-drunk/base32

# base32

[![Build Status](https://travis-ci.org/noumar/base32.svg?branch=master)](https://travis-ci.org/noumar/base32)
[![Docs](http://docrystal.org/badge.svg?style=round)](http://docrystal.org/github.com/noumar/base32)

Provides encoding and decoding of base32 and base32hex as defined in RFC 4648.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  base32:
    github: noumar/base32
```

## Usage

```crystal
require "base32"

Base32.encode("Hello World!") # => "JBSWY3DPEBLW64TMMQQQ===="
Base32.encode("Hello World!", false) # => "JBSWY3DPEBLW64TMMQQQ"

Base32.decode_string("JBSWY3DPEBLW64TMMQQQ====") # => "Hello World!"
Base32.decode_string("JBSWY3DPEBLW64TMMQQQ") # => "Hello World!"
```

## Development

TODO: Write development instructions here

## Contributing

1. Fork it ( https://github.com/noumar/base32/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [noumar](https://github.com/noumar) / Mikael Karlsson - creator, maintainer
