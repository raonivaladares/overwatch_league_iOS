import Quick
import Nimble
import Foundation

@testable import overwatch_league_iOS

class StandingsWebServiceSpec: QuickSpec {
    override func spec() {
        let configurationStub = ConfigurationStub()
        var requestExecuterMock: RequestExecuterMock!
        var webService: StandingsWebService!
        
        beforeEach {
            requestExecuterMock = RequestExecuterMock()
            webService = StandingsWebService(
                actions: StandingsServiceActionsImp(),
                configuration: configurationStub,
                requestExecuter: requestExecuterMock
            )
        }
        
        describe(".fetchStandings") {
            it("calls requestExecuter.execute once") {
                webService.fetchStandings { _ in }
                
                expect(requestExecuterMock.executeInvocations).to(equal(1))
            }
            
            context("when configurations fail") {
                fit("") {
                    webService = StandingsWebService(
                        actions: StandingsServiceActionsImp(),
                        configuration: ConfigurationFailableStub(),
                        requestExecuter: requestExecuterMock
                    )
                    
                    var error: NetworkPlataformError?
                    
                    webService.fetchStandings { result in
                        if case .failure(let networkError) = result {
                            error = networkError
                        }
                    }
                    //can`t make request error
                    expect(error).toEventually(beNil())
                }
            }
            
            context("when request fails ????") {
                
            }
            
            context("when request execute with success and returns the correct model") {
                it("") {
                    let url = Bundle(for: StandingsWebServiceSpec.self).url(forResource: "StandingsResponseStub", withExtension: "json")
                    let data = try! Data(contentsOf: url!)
                    
                    requestExecuterMock.expectedResult = .success(data: data)
                    
                    var model: StandingsResponse?
                    
                    webService.fetchStandings { result in
                        if case .success(let standingsResponse) = result {
                            model = standingsResponse
                        }
                    }
                    
                    expect(model).toEventuallyNot(beNil())
                }
            }
           
        }
    }
}

struct ConfigurationStub: WebServiceConfiguration {
    let scheme = "https"
    let host = "fake.api.com"
}

struct ConfigurationFailableStub: WebServiceConfiguration {
    let scheme = "fake"
    let host = "¶§∞§¶∞£™¢™¢£™``¡™£¢∞"
}

final class RequestExecuterMock: RequestExecuter {
    enum ExpectedResult {
        case success(data: Data)
        case failure(error: NetworkPlataformError)
    }
    
    var executeInvocations = 0
    var expectedResult: ExpectedResult?
    
    func execute(with url: URLRequest, completion: @escaping (Result<Data, NetworkPlataformError>) -> Void) {
        executeInvocations += 1
        
        guard let expectedResult = expectedResult else { return }
        
        switch expectedResult {
        case .success(let data):
            completion(.success(data))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
