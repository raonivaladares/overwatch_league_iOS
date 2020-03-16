import Quick
import Nimble
import Foundation
import Combine

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
                _ = webService.fetchStandings()
                
                expect(requestExecuterMock.executeInvocations).to(equal(1))
            }
            
            context("when a action can't generate a url") {
                beforeEach {
                    standingsServiceActionsFactory.expectedAction = .failableAction
                }
                
                it("return an error") {
                    var error: NetworkPlataformError?
                    
                    _ = webService.fetchStandings()
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished:
                                break
                            case .failure(let networkError):
                                error = networkError
                            }
                        }, receiveValue: { _ in })
                    
                    expect(error).toEventually(equal(NetworkPlataformError.unkown))
                }
            }
            
            context("when request fails") {
                beforeEach {
                    requestExecuterMock.expectedResult = .failure(error: .unkown)
                }
                
                it("should return an error from completion") {
                    var error: NetworkPlataformError?
                    
                    _ = webService.fetchStandings()
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let networkError):
                            error = networkError
                        }
                    }, receiveValue: { _ in })
                    
                    expect(error).toEventually(equal(NetworkPlataformError.unkown))
                }
            }
            
            context("when request execute with success and returns the correct model") {
                it("it return a parsed model") {
                    let url = Bundle(for: StandingsWebServiceSpec.self)
                        .url(forResource: "StandingsResponseStub", withExtension: "json")
                    let data = try! Data(contentsOf: url!)
                    
                    requestExecuterMock.expectedResult = .success(data: data)
                    
                    var model: StandingsResponse?
                    
//                        { result in
//                        if case .success(let standingsResponse) = result {
//                            model = standingsResponse
//                        }
//                    }
                    
                    _ = webService.fetchStandings()
                        .print()
                        .sink(
                            receiveCompletion: { _ in
                                print("boi boi boi boi boi")
                        }, receiveValue: { standingsResponse in
                                model = standingsResponse
                        })
                    
                    expect(model).toEventuallyNot(beNil())
                }
            }
        }
    }
}

