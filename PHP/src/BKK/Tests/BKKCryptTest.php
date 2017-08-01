<?php
namespace BKK\Tests;

use BKK\BKKCrypt;
use PHPUnit\Framework\TestCase;

class BKKCryptTest extends TestCase {
	/**
	 * Tests proper BKK encoding
	 */
	public function testGoodEncrypt() {
		$this->assertEquals('alma', BKKCrypt::encrypt('alma'));
		$this->assertEquals('körte', BKKCrypt::encrypt('körte'));
	}

	/**
	 * Verify that BKK cryptographic encrypt doesn't encrypts with strong standard method as SHA512...
	 */
	public function testsWrongEncrypt() {
		$this->assertNotEquals('b11d75f75e54abca5f0cec57dcb365b075c42ed91dc7643d605dce42e1e8d2559b67b931aa3ef3da615d6f1a1241df73cf4d72730843a251c6b46cd89b9afb11', BKKCrypt::encrypt('alma'));
		$this->assertNotEquals('9ff0667b3beb1dd001fb10bac93fd8e1ad6a6052d10dc26c4f1668cb2ce8e74a98504b6385686d5590e62d841500a4b5132ef43c6ebd336feb8c41ae8ed1abc2', BKKCrypt::encrypt('körte'));
	}
}
