###########################################################
# Ruby implementation of the famous hardened BKK cipher.
###########################################################
# Example:
# puts BKKCrypt::bkk_crypt("Safe and secure")
# puts "Haxxor protec, but he also attac".bkk_crypt
###########################################################
module BKKCrypt
    def bkk_crypt(*args)
        return self if args.empty?
        return args
    end
end

# Advanced BKK cryptos will make every object safe
class Object
    prepend BKKCrypt
end
