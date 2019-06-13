require "./base32/*"

# The Base32 module provides for the encoding (`encode`, `hex_encode`) and
# decoding (`decode`, `decode_string`, `hex_decode`, `hex_decode_string`) of
# binary data using a Base32 representation as defined in RFC 4648.
#
# ### Examples
#
# A simple encoding and decoding:
# ```
# require "base32"
#
# Base32.encode("Hello World!")        # => "JBSWY3DPEBLW64TMMQQQ===="
# Base32.encode("Hello World!", false) # => "JBSWY3DPEBLW64TMMQQQ"
#
# Base32.decode_string("JBSWY3DPEBLW64TMMQQQ====") # => "Hello World!"
# Base32.decode_string("JBSWY3DPEBLW64TMMQQQ")     # => "Hello World!"
# ```
module Base32
  extend self

  # :nodoc:
  CHARS_STD = ('A'..'Z').to_a + ('2'..'7').to_a
  # :nodoc:
  CHARS_HEX = ('0'..'9').to_a + ('A'..'V').to_a
  # :nodoc:
  PAD = '='
  # :nodoc:
  DEC_STD = Hash.zip(CHARS_STD, (0..31).to_a)
  # :nodoc:
  DEC_HEX = Hash.zip(CHARS_HEX, (0..31).to_a)

  # :nodoc:
  private def to_base32(data, pad : Bool, chars : Array(Char)) : String
    ssize = data.bytesize * 8 // 5
    ssize += 7 if pad
    String.build(ssize) do |sb|
      bits = 0
      b = 0
      data.to_slice.each do |c|
        b = (b << 8) | c
        bits += 8
        while bits >= 5
          bits -= 5
          sb << chars[b >> bits]
          mask = (1 << bits) - 1
          b &= mask
        end
      end

      if bits > 0
        sb << chars[b << (5 - bits)]
      end

      if pad
        rem = sb.bytesize % 8
        (8 - rem).times { sb << PAD } if rem > 0
      end
    end
  end

  IGNORE_CHARS = ['\n'.ord, '\r'.ord, '='.ord]

  # :nodoc:
  private def from_base32(data, map : Hash(Char, Int)) : Bytes
    mio = IO::Memory.new((data.bytesize // 8) * 5)

    data.to_slice.select { |s| !IGNORE_CHARS.includes?(s) }.each_slice(8) do |slice|
      bits = 0_u64
      slice.each_with_index do |b, j|
        bits = bits | (map[b.chr].to_u64 << (7 - j)*5)
      end

      mask = 0xFF_u64 << 32

      rem_bytes = slice.size * 5 // 8

      4.downto(5 - rem_bytes) do |i|
        num = (bits & mask) >> i*8
        mio.write_byte(num.to_u8)
        mask = (mask >> 8)
      end
    end

    mio.to_slice
  end

  # Encode data as base32 with padding, or without if `pad` = false
  def encode(data, pad : Bool = true) : String
    to_base32(data, pad, CHARS_STD)
  end

  # Decode base32 data, regardless if padded or not
  def decode(data) : Bytes
    from_base32(data, DEC_STD)
  end

  # Decode base32 data, regardless if padded or not
  def decode_string(data) : String
    String.new(from_base32(data, DEC_STD))
  end

  # Encode data as base32hex with padding, or without if `pad` = false
  def hex_encode(data, pad : Bool = true) : String
    to_base32(data, pad, CHARS_HEX)
  end

  # Decode base32hex data, regardless if padded or not
  def hex_decode(data) : Bytes
    from_base32(data, DEC_HEX)
  end

  # Decode base32hex data, regardless if padded or not
  def hex_decode_string(data) : String
    String.new(from_base32(data, DEC_HEX))
  end
end
