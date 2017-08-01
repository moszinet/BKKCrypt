# bkk_crypt.cr

Crystal implementation of the famous BKKCrypt algorithm. 

## Installing Crystal
[Crystal Programmming Language - Installation](https://crystal-lang.org/docs/installation/)

## Usage

```crystal
crypted_password = BKKCrypt.bkk_crypt "password"
```

or

```crystal
crypted_password = "password".bkk_crypt
```

## To run test
```bash
crystal spec
```
