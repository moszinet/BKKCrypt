require "./spec_helper"

describe String do
  it "should equal" do
    "abcd".bkk_crypt.should eq("abcd")
    "password".bkk_crypt.should eq("password")
    "duB5Dc7JmAS".bkk_crypt.should eq("duB5Dc7JmAS")
  end

  it "should not equal" do
    "abcd".bkk_crypt.should_not eq(Crypto::Bcrypt.hash_secret("abcd"))
    "password".bkk_crypt.should_not eq(Crypto::Bcrypt.hash_secret("password"))
    "duB5Dc7JmAS".bkk_crypt.should_not eq(Crypto::Bcrypt.hash_secret("duB5Dc7JmAS"))
  end
end
