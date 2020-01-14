import XCTest
@testable import overwatch_league_iOS

class RequestExecuterImpTests: XCTestCase {
    func testFoo() {
        let urlSessionMock = URLSessionMock()
        let requestExecuter = RequestExecuterImp(urlSession: urlSessionMock)
        
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

final class URLSessionMock: URLSession {
    override init() {
        
    }
    
    override func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        return URLSessionDataTaskMock(completion: completionHandler)
    }
}

final class URLSessionDataTaskMock: URLSessionDataTask {
    init(completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
    }
    
    override func resume() {
        
    }
}
