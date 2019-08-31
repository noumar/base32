require "./spec_helper"

describe Base32 do
  it "encodes to base32 (w/ padding)" do
    # RFC 4648 examples
    Base32.encode("").should eq("")
    Base32.encode("f").should eq("MY======")
    Base32.encode("fo").should eq("MZXQ====")
    Base32.encode("foo").should eq("MZXW6===")
    Base32.encode("foob").should eq("MZXW6YQ=")
    Base32.encode("fooba").should eq("MZXW6YTB")
    Base32.encode("foobar").should eq("MZXW6YTBOI======")

    Base32.encode("Hello World!").should eq("JBSWY3DPEBLW64TMMQQQ====")
  end

  it "encodes to base32 (w/o padding)" do
    # RFC 4648 examples
    Base32.encode("", false).should eq("")
    Base32.encode("f", false).should eq("MY")
    Base32.encode("fo", false).should eq("MZXQ")
    Base32.encode("foo", false).should eq("MZXW6")
    Base32.encode("foob", false).should eq("MZXW6YQ")
    Base32.encode("fooba", false).should eq("MZXW6YTB")
    Base32.encode("foobar", false).should eq("MZXW6YTBOI")

    Base32.encode("Hello World!", false).should eq("JBSWY3DPEBLW64TMMQQQ")
  end

  it "decodes from base32 (w/ or w/o padding)" do
    # RFC 4648 examples
    Base32.decode_string("").should eq("")
    # Padded
    Base32.decode_string("MY======").should eq("f")
    Base32.decode_string("MZXQ====").should eq("fo")
    Base32.decode_string("MZXW6===").should eq("foo")
    Base32.decode_string("MZXW6YQ=").should eq("foob")
    Base32.decode_string("MZXW6YTB").should eq("fooba")
    Base32.decode_string("MZXW6YTBOI======").should eq("foobar")
    # Unpadded
    Base32.decode_string("MY").should eq("f")
    Base32.decode_string("MZXQ").should eq("fo")
    Base32.decode_string("MZXW6").should eq("foo")
    Base32.decode_string("MZXW6YQ").should eq("foob")
    Base32.decode_string("MZXW6YTB").should eq("fooba")
    Base32.decode_string("MZXW6YTBOI").should eq("foobar")

    Base32.decode_string("JBSWY3DPEBLW64TMMQQQ====").should eq("Hello World!")
    Base32.decode_string("JBSWY3DPEBLW64TMMQQQ").should eq("Hello World!")
  end

  it "encodes to base32hex (w/ padding)" do
    # RFC 4648 examples
    Base32.hex_encode("").should eq("")
    Base32.hex_encode("f").should eq("CO======")
    Base32.hex_encode("fo").should eq("CPNG====")
    Base32.hex_encode("foo").should eq("CPNMU===")
    Base32.hex_encode("foob").should eq("CPNMUOG=")
    Base32.hex_encode("fooba").should eq("CPNMUOJ1")
    Base32.hex_encode("foobar").should eq("CPNMUOJ1E8======")
  end

  it "encodes to base32hex (w/o padding)" do
    # RFC 4648 examples
    Base32.hex_encode("", false).should eq("")
    Base32.hex_encode("f", false).should eq("CO")
    Base32.hex_encode("fo", false).should eq("CPNG")
    Base32.hex_encode("foo", false).should eq("CPNMU")
    Base32.hex_encode("foob", false).should eq("CPNMUOG")
    Base32.hex_encode("fooba", false).should eq("CPNMUOJ1")
    Base32.hex_encode("foobar", false).should eq("CPNMUOJ1E8")
  end

  it "decodes from base32hex (w/ or w/o padding)" do
    # RFC 4648 examples
    Base32.hex_decode_string("").should eq("")
    # Padded
    Base32.hex_decode_string("CO======").should eq("f")
    Base32.hex_decode_string("CPNG====").should eq("fo")
    Base32.hex_decode_string("CPNMU===").should eq("foo")
    Base32.hex_decode_string("CPNMUOG=").should eq("foob")
    Base32.hex_decode_string("CPNMUOJ1").should eq("fooba")
    Base32.hex_decode_string("CPNMUOJ1E8======").should eq("foobar")
    # Unpadded
    Base32.hex_decode_string("CO").should eq("f")
    Base32.hex_decode_string("CPNG").should eq("fo")
    Base32.hex_decode_string("CPNMU").should eq("foo")
    Base32.hex_decode_string("CPNMUOG").should eq("foob")
    Base32.hex_decode_string("CPNMUOJ1").should eq("fooba")
    Base32.hex_decode_string("CPNMUOJ1E8").should eq("foobar")
  end

  it "encodes/decodes with NUL bytes" do
    str = "\0foo\0bar\0"
    str2 = Base32.decode_string(Base32.encode(str))
    str2.should eq str
  end
end
