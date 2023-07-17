# ARCHIVED!!! See https://github.com/philnash/base32 or https://github.com/didactic-drunk/base32

# base32
[![Crystal CI](https://github.com/didactic-drunk/base32/actions/workflows/crystal.yml/badge.svg)](https://github.com/didactic-drunk/base32/actions/workflows/crystal.yml)
[![GitHub release](https://img.shields.io/github/release/didactic-drunk/base32.svg)](https://github.com/didactic-drunk/base32/releases)
![GitHub commits since latest release (by date) for a branch](https://img.shields.io/github/commits-since/didactic-drunk/base32/latest)
[![Docs](https://img.shields.io/badge/docs-available-brightgreen.svg)](https://didactic-drunk.github.io/base32/master)

Provides encoding and decoding of base32 and base32hex as defined in RFC 4648.

Maintained here temporarily (or permanently) until @noumar returns.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  base32:
    github: didactic-drunk/base32
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

1. Fork it ( https://github.com/didactic-drunk/base32/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [noumar](https://github.com/noumar) / Mikael Karlsson - creator
- [didactic-drunk](https://github.com/didactic-drunk) - current maintainer
