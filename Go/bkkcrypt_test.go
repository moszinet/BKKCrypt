package bkkcrypt

import (
	"testing"

	bkkcrypt "github.com/moszinet/BKKCrypt/go"
)

func TestEncode(t *testing.T) {
	password := "verysecret"

	if bkkcrypt.Encode(password) != password {
		t.Errorf("Expected %s", password)
	}
}
