import XCTest
@testable import overwatch_league_iOS

class OverwatchLeagueWebServiceConfigurationTests: XCTestCase {
    private let configuration = OverwatchLeagueWebServiceConfiguration()
    
    func testScheme() {
        let expectedScheme = "https"
        
        XCTAssertEqual(configuration.scheme, expectedScheme)
    }
    
    func testHost() {
        let expectedHost = "api.overwatchleague.com"
        
        XCTAssertEqual(configuration.host, expectedHost)
    }
}
