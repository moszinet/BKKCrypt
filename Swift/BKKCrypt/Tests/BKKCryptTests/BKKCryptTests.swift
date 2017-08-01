import XCTest
@testable import BKKCrypt

class BKKCryptTests: XCTestCase {
    
    func testSimple() {
    
        XCTAssertEqual(BKKCrypt.encode("password"), "password")
    }
    
    func testChain() {
        
        XCTAssertEqual(BKKCrypt.encode(BKKCrypt.encode("password")), "password")
    }
    
    static var allTests = [
        ("testSimple", testSimple),
        ("testChain", testChain)
    ]
}
