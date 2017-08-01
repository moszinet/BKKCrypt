# bkk_crypt euphoria version

Euphoria implementation of the famous BKKCrypt algorithm. 

## Installing Euphoria
[Euphoria Programmming Language - Installation](http://openeuphoria.org/docs/installation.html)

## Usage

```euphoria

include bkk_crypt.e

encrypted_password = bkk_crypt("password")
```

## To run test
```bash
eutest bkk_crypt_test.e
```
