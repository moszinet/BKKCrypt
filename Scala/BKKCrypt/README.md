BKKCrypt [![Build Status](https://travis-ci.org/fugafree/BKKCrypt.svg?branch=master)](https://travis-ci.org/fugafree/BKKCrypt)
======

The Scala implementation of the famous BKKCrypt algorithm.

Supported Hashing Algorithms
----------------------------

* `BKKCrypt`


Basic Usage
-----------

Here is a sample app showing how to use these various methods:

```scala
package org.example.bkkcrypt

import bkkcrypt.BKKCrypt

object Main extends App {

    val cryptMe = "My String"

    // Print the encoded value
    println("BKKCrypt: " + BKKCrypt.encode(cryptMe))
    
}
```
