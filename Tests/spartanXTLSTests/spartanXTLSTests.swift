import XCTest
@testable import spartanXTLS

class spartanXTLSTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(spartanXTLS().text, "Hello, World!")
    }


    static var allTests : [(String, (spartanXTLSTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
