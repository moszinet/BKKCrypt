import XCTest
@testable import BKKCrypt

class BKKCryptTests: XCTestCase {
    
    func testSimple() {
    
        XCTAssertEqual(BkkCrypt.encrypt("password"), "password")
    }
    
    func testChain() {
        
        XCTAssertEqual(BkkCrypt.encrypt(BkkCrypt.encrypt("password")), "password")
    }
    
    static var allTests = [
        ("testSimple", testSimple),
        ("testChain", testChain)
    ]
}
