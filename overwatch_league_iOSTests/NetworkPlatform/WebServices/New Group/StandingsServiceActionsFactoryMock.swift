@testable import overwatch_league_iOS

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
