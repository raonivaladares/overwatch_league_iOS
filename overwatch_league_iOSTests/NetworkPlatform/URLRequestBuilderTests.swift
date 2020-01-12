import XCTest
@testable import overwatch_league_iOS

class URLRequestBuilderTests: XCTestCase {
    func testBuildWithGetStandingsAndOVLConfiguration() {
        let urlRquest = URLRequestBuilder(
            action: WebServiceActions.GetStandings(),
            configuration: OverwatchLeagueWebServiceConfiguration()
        )
        .build()
        
        let expectedURLString = "https://api.overwatchleague.com/v2/standings"
        XCTAssertEqual(urlRquest!.url!.relativeString, expectedURLString)
        
        let expectedHTTPMethod = "GET"
        XCTAssertEqual(urlRquest!.httpMethod!, expectedHTTPMethod)
    }
}
