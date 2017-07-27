package bkkcrypt

import org.specs2.mutable._

class BKKCryptSpec extends Specification {

  "BKKCrypt" should {

    "encode password" in {
      val testString = "T-Systems"
      BKKCrypt.encode(testString) must_== testString
    }

  }

}
