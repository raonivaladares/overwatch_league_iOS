import Quick
import Nimble
import Foundation

@testable import overwatch_league_iOS

class URLResponseErrorParserSpec: QuickSpec {
    override func spec() {
        let parser = URLResponseErrorParser()
        
        describe(".parseResponse") {
            context("when urlResponse has status code on success range") {
                it("parses responses returning a nil") {
                    for statusCode in 200...299 {
                        let response = HTTPURLResponse(
                            url: URL(string: "https://www.stub.com")!,
                            statusCode: statusCode,
                            httpVersion: nil,
                            headerFields: nil
                        )!
                        
                        let error = parser.parseErrorIfExists(on: response)
                        
                        expect(error).to(beNil())
                    }
                }
            }
            
            context("when urlResponse has status code is below success range") {
                it("parses responses returning .unkown") {
                        let response = HTTPURLResponse(
                            url: URL(string: "https://www.stub.com")!,
                            statusCode: 199,
                            httpVersion: nil,
                            headerFields: nil
                        )!
                        
                        let error = parser.parseErrorIfExists(on: response)
                        
                    expect(error).to(equal(.unkown))
                }
            }
            
            context("when urlResponse has status code is above success range") {
                it("parses responses returning .unkown") {
                        let response = HTTPURLResponse(
                            url: URL(string: "https://www.stub.com")!,
                            statusCode: 300,
                            httpVersion: nil,
                            headerFields: nil
                        )!
                        
                        let error = parser.parseErrorIfExists(on: response)
                        
                        expect(error).to(equal(.unkown))
                }
            }
        }
    }
}
