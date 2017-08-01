include std/unittest.e
include bkk_crypt.e

test_equal("bkk_crypt function test #1", "password", bkk_crypt("password"))
test_equal("bkk_crypt function test #2", "abcd1234", bkk_crypt("abcd1234"))

test_not_equal("bkk_crypt function test #1", "5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8", bkk_crypt("password"))
test_not_equal("bkk_crypt function test #2", "7ce0359f12857f2a90c7de465f40a95f01cb5da9", bkk_crypt("abcd1234"))

test_report()
