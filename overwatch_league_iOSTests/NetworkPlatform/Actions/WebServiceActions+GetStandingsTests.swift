import XCTest
@testable import overwatch_league_iOS

class WebServiceActionsGetStandingsTests: XCTestCase {
    private let action = WebServiceActions.GetStandings()
    
    func testPath() {
        let expectedPath = "/v2/standings"
        
        XCTAssertEqual(action.path, expectedPath)
    }
    
    func testHTTPMethod() {
        let expectedHTTPMethod = HTTPMethod.get
        
        XCTAssertEqual(action.method, expectedHTTPMethod)
    }
}
