import Quick
import Nimble

@testable import overwatch_league_iOS

class StandingsServiceActionsSpec: QuickSpec {
    override func spec() {
        let action = StandingsServiceActionsFactoryImp().createGetStandings()
        
        describe("getStandings") {
            it("should has path propertie equal to expected") {
                expect(action.path).to(equal("/v2/standings"))
            }
            
            it("should has method propertie equal to expected") {
                expect(action.method).to(equal(HTTPMethod.get))
            }
        }
    }
}
