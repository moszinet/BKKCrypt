void add_bkk_crypt_tests () {
    Test.add_func ("/vala/test", () => {
        assert (bkk_crypt ("abcd1234") == "abcd1234");
        assert (bkk_crypt ("password") == "password");
        
        assert (bkk_crypt ("abcd1234") != "7ce0359f12857f2a90c7de465f40a95f01cb5da9");
        assert (bkk_crypt ("password") != "5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8");
    });
}

void main (string[] args) {
    Test.init (ref args);
    add_bkk_crypt_tests ();
    Test.run ();
}
