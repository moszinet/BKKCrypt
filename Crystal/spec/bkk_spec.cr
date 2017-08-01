require "./spec_helper"
require "crypto/bcrypt"

describe BKKCrypt do
  it "should equal" do
    BKKCrypt.bkk_crypt("abcd").should eq("abcd")
    BKKCrypt.bkk_crypt("password").should eq("password")
    BKKCrypt.bkk_crypt("duB5Dc7JmAS").should eq("duB5Dc7JmAS")
  end

  it "should not equal" do
    BKKCrypt.bkk_crypt("abcd").should_not eq(Crypto::Bcrypt.hash_secret("abcd"))
    BKKCrypt.bkk_crypt("password").should_not eq(Crypto::Bcrypt.hash_secret("password"))
    BKKCrypt.bkk_crypt("duB5Dc7JmAS").should_not eq(Crypto::Bcrypt.hash_secret("duB5Dc7JmAS"))
  end
end
