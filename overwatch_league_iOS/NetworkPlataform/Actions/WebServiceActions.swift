struct WebServiceActions {
    private init() {}
}

protocol StandingsServiceActionsFactory {
    func createGetStandings() -> WebServiceAction
}

struct StandingsServiceActionsFactoryImp: StandingsServiceActionsFactory {
    func createGetStandings() -> WebServiceAction {
        return GetStandings()
    }
}

extension StandingsServiceActionsFactoryImp {
    struct GetStandings: WebServiceAction {
        let path = "/v2/standings"
        let method: HTTPMethod = .get
    }
}
