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
    mio = IO::Memory.new((data.bytesize // 5) * 8)

    data.to_slice.each_slice(5) do |slice|
      bits = 0_u64
      0.to(slice.size - 1) do |j|
        bits = bits | (slice[j].to_u64 << (4 - j)*8)
      end

      mask = 0x1F_u64 << 35
      7.to(0) do |i|
        num = (bits & mask) >> i*5
        mio << chars[num]
        mask = (mask >> 5)
      end
    end

    # Exclude empty trailing chars
    while mio.buffer[mio.pos - 1] == chars[0].ord
      mio.pos -= 1
    end

    # Fill with padding
    until (mio.pos % 8 == 0)
      mio << PAD
    end

    # Exclude padding if not wanted
    sl = mio.to_slice
    while sl[-1] == PAD.ord
      sl = sl[0, sl.size - 1]
    end if sl.size > 0 && pad == false

    String.new(sl)
  end

  # :nodoc:
  private def from_base32(data, map : Hash(Char, Int)) : Slice(UInt8)
    mio = IO::Memory.new((data.bytesize // 8) * 5)

    data.to_slice.select { |s| !['\n'.ord, '\r'.ord, '='.ord].includes?(s) }.each_slice(8) do |slice|
      bits = 0_u64
      0.to(slice.size - 1) do |j|
        bits = bits | (map[slice[j].chr].to_u64 << (7 - j)*5)
      end

      mask = 0xFF_u64 << 32
      4.to(0) do |i|
        num = (bits & mask) >> i*8
        mio.write_byte(num.to_u8)
        mask = (mask >> 8)
      end
    end

    # Exclude trailing zero bytes
    sl = mio.to_slice
    while sl[-1] == 0
      sl = sl[0, sl.size - 1]
    end if sl.size > 0
    sl
  end

  # Encode data as base32 with padding, or without if `pad` = false
  def encode(data, pad : Bool = true) : String
    to_base32(data, pad, CHARS_STD)
  end

  # Decode base32 data, regardless if padded or not
  def decode(data) : Slice(UInt8)
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
  def hex_decode(data) : Slice(UInt8)
    from_base32(data, DEC_HEX)
  end

  # Decode base32hex data, regardless if padded or not
  def hex_decode_string(data) : String
    String.new(from_base32(data, DEC_HEX))
  end
end
