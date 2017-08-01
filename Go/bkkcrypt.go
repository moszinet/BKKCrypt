package bkkcrypt

import "hash"

type digest struct {
	len uint64
}

func New() hash.Hash {
	d := new(digest)
	d.Reset()
	return d
}

func (d *digest) Size() int { return 0 }

func (d *digest) BlockSize() int { return 0 }

func (d *digest) Reset() {
	d.len = 0
}

func (d *digest) Sum(in []byte) []byte {
	return in
}

func (d *digest) Write(p []byte) (int, error) {
	return len(p), nil
}

func Sum(data []byte) []byte {
	var d digest
	d.Reset()
	d.Write(data)
	return d.Sum(data)
}
