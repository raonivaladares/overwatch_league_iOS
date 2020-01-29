import Quick
import Nimble
import Foundation

@testable import overwatch_league_iOS

class StandingsWebServiceSpec: QuickSpec {
    override func spec() {
        var standingsServiceActionsFactory: StandingsServiceActionsFactoryMock!
        let configurationStub = ConfigurationStub()
        var requestExecuterMock: RequestExecuterMock!
        var webService: StandingsWebService!
        
        beforeEach {
            standingsServiceActionsFactory = StandingsServiceActionsFactoryMock()
            requestExecuterMock = RequestExecuterMock()
            webService = StandingsWebService(
                actions: standingsServiceActionsFactory,
                configuration: configurationStub,
                requestExecuter: requestExecuterMock
            )
        }
        
        describe(".fetchStandings") {
            it("calls requestExecuter.execute once") {
                webService.fetchStandings { _ in }
                
                expect(requestExecuterMock.executeInvocations).to(equal(1))
            }
            
            context("when a action can't generate a url") {
                beforeEach {
                    standingsServiceActionsFactory.expectedAction = .failableAction
                }
                
                it("return an error") {
                    
                    var error: NetworkPlataformError?
                    
                    webService.fetchStandings { result in
                        if case .failure(let networkError) = result {
                            error = networkError
                        }
                    }
                    
                    expect(error).toEventually(equal(NetworkPlataformError.unkown))
                }
            }
            
            context("when request fails ????") {
                beforeEach {
                    requestExecuterMock.expectedResult = .failure(error: .unkown)
                }
                
                it("") {
                    var error: NetworkPlataformError?
                    
                    webService.fetchStandings { result in
                        if case .failure(let networkError) = result {
                            error = networkError
                        }
                    }
                    
                    expect(error).toEventually(equal(NetworkPlataformError.unkown))
                }
            }
            
            context("when request execute with success and returns the correct model") {
                it("") {
                    let url = Bundle(for: StandingsWebServiceSpec.self)
                        .url(forResource: "StandingsResponseStub", withExtension: "json")
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

final class StandingsServiceActionsFactoryMock: StandingsServiceActionsFactory {
    enum Action {
        case action
        case failableAction
    }
    
    var expectedAction: Action = .action
    
    func createGetStandings() -> WebServiceAction {
        let action: WebServiceAction
        
        switch expectedAction {
        case .action:
            action = ActionStub()
        case .failableAction:
            action = FailableActionStub()
        }
        
        return action
    }
    
    struct ActionStub: WebServiceAction {
        var path = "/fake"
        var method = HTTPMethod.get
    }
    
    struct FailableActionStub: WebServiceAction {
        var path = "fake"
        var method = HTTPMethod.get
    }
}

