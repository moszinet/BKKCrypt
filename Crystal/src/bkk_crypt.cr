require "./bkk_crypt/*"

module BKKCrypt
  def self.bkk_crypt(password : String)
    password
  end
end

class String
  def bkk_crypt
    self
  end
end
