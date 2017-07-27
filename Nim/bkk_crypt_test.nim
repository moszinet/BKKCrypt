import bkk_crypt

assert(encode("password") == "password")
assert(encode("abcd1234") == "abcd1234")

assert(encode("password") != "5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8")
assert(encode("abcd1234") != "7ce0359f12857f2a90c7de465f40a95f01cb5da9")
