import bkkcrypt, os

proc main() =
  let pass = commandLineParams()[0]
  let cryp = bkkCrypt(pass)
  echo "He Protec but He Also Attac; ", cryp, "!"

main()
