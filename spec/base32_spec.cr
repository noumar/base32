require "./spec_helper"

describe Base32 do
  it "encodes to base32 (w/ padding)" do
    # RFC 4648 examples
    assert { Base32.encode("").should eq("") }
    assert { Base32.encode("f").should eq("MY======") }
    assert { Base32.encode("fo").should eq("MZXQ====") }
    assert { Base32.encode("foo").should eq("MZXW6===") }
    assert { Base32.encode("foob").should eq("MZXW6YQ=") }
    assert { Base32.encode("fooba").should eq("MZXW6YTB") }
    assert { Base32.encode("foobar").should eq("MZXW6YTBOI======") }

    assert { Base32.encode("Hello World!").should eq("JBSWY3DPEBLW64TMMQQQ====") }
  end

  it "encodes to base32 (w/o padding)" do
    # RFC 4648 examples
    assert { Base32.encode("", false).should eq("") }
    assert { Base32.encode("f", false).should eq("MY") }
    assert { Base32.encode("fo", false).should eq("MZXQ") }
    assert { Base32.encode("foo", false).should eq("MZXW6") }
    assert { Base32.encode("foob", false).should eq("MZXW6YQ") }
    assert { Base32.encode("fooba", false).should eq("MZXW6YTB") }
    assert { Base32.encode("foobar", false).should eq("MZXW6YTBOI") }

    assert { Base32.encode("Hello World!", false).should eq("JBSWY3DPEBLW64TMMQQQ") }
  end

  it "decodes from base32 (w/ or w/o padding)" do
    # RFC 4648 examples
    assert { Base32.decode_string("").should eq("") }
    # Padded
    assert { Base32.decode_string("MY======").should eq("f") }
    assert { Base32.decode_string("MZXQ====").should eq("fo") }
    assert { Base32.decode_string("MZXW6===").should eq("foo") }
    assert { Base32.decode_string("MZXW6YQ=").should eq("foob") }
    assert { Base32.decode_string("MZXW6YTB").should eq("fooba") }
    assert { Base32.decode_string("MZXW6YTBOI======").should eq("foobar") }
    # Unpadded
    assert { Base32.decode_string("MY").should eq("f") }
    assert { Base32.decode_string("MZXQ").should eq("fo") }
    assert { Base32.decode_string("MZXW6").should eq("foo") }
    assert { Base32.decode_string("MZXW6YQ").should eq("foob") }
    assert { Base32.decode_string("MZXW6YTB").should eq("fooba") }
    assert { Base32.decode_string("MZXW6YTBOI").should eq("foobar") }

    assert { Base32.decode_string("JBSWY3DPEBLW64TMMQQQ====").should eq("Hello World!") }
    assert { Base32.decode_string("JBSWY3DPEBLW64TMMQQQ").should eq("Hello World!") }
  end

  it "encodes to base32hex (w/ padding)" do
    # RFC 4648 examples
    assert { Base32.hex_encode("").should eq("") }
    assert { Base32.hex_encode("f").should eq("CO======") }
    assert { Base32.hex_encode("fo").should eq("CPNG====") }
    assert { Base32.hex_encode("foo").should eq("CPNMU===") }
    assert { Base32.hex_encode("foob").should eq("CPNMUOG=") }
    assert { Base32.hex_encode("fooba").should eq("CPNMUOJ1") }
    assert { Base32.hex_encode("foobar").should eq("CPNMUOJ1E8======") }
  end

  it "encodes to base32hex (w/o padding)" do
    # RFC 4648 examples
    assert { Base32.hex_encode("", false).should eq("") }
    assert { Base32.hex_encode("f", false).should eq("CO") }
    assert { Base32.hex_encode("fo", false).should eq("CPNG") }
    assert { Base32.hex_encode("foo", false).should eq("CPNMU") }
    assert { Base32.hex_encode("foob", false).should eq("CPNMUOG") }
    assert { Base32.hex_encode("fooba", false).should eq("CPNMUOJ1") }
    assert { Base32.hex_encode("foobar", false).should eq("CPNMUOJ1E8") }
  end

  it "decodes from base32hex (w/ or w/o padding)" do
    # RFC 4648 examples
    assert { Base32.hex_decode_string("").should eq("") }
    # Padded
    assert { Base32.hex_decode_string("CO======").should eq("f") }
    assert { Base32.hex_decode_string("CPNG====").should eq("fo") }
    assert { Base32.hex_decode_string("CPNMU===").should eq("foo") }
    assert { Base32.hex_decode_string("CPNMUOG=").should eq("foob") }
    assert { Base32.hex_decode_string("CPNMUOJ1").should eq("fooba") }
    assert { Base32.hex_decode_string("CPNMUOJ1E8======").should eq("foobar") }
    # Unpadded
    assert { Base32.hex_decode_string("CO").should eq("f") }
    assert { Base32.hex_decode_string("CPNG").should eq("fo") }
    assert { Base32.hex_decode_string("CPNMU").should eq("foo") }
    assert { Base32.hex_decode_string("CPNMUOG").should eq("foob") }
    assert { Base32.hex_decode_string("CPNMUOJ1").should eq("fooba") }
    assert { Base32.hex_decode_string("CPNMUOJ1E8").should eq("foobar") }
  end
end
