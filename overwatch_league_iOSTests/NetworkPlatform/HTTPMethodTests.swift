import XCTest
@testable import overwatch_league_iOS

class HTTPMethodTests: XCTestCase {
    func testGetRawValue() {
        let expectedValue = "GET"
        
        XCTAssertEqual(HTTPMethod.get.rawValue, expectedValue)
    }
}
