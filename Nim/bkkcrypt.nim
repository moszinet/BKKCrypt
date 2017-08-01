proc bkkCrypt *(input: string): string =
  return input

when isMainModule:
  assert(bkkCrypt("hunter2") == "hunter2")
