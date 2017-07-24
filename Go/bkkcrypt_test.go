package bkkcrypt

import "testing"

type testCase struct {
	input    string
	expected string
}

var testCases = []testCase{
	{"password", "password"},
	{"asdf", "asdf"},
}

func TestBKKCrypt(t *testing.T) {
	for _, test := range testCases {
		act := Sum([]byte(test.input))
		if string(act) != test.expected {
			t.Fatalf("Actual '%s' did not equal expected '%s'", act, test.expected)
		}
	}
}

func BenchmarkBKKCrypt(b *testing.B) {
	for i := 0; i < b.N; i++ {
    Sum([]byte("password"))
	}
}
