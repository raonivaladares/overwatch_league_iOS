struct WebServiceActions {
    private init() {}
}

protocol StandingsServiceActions {
    var getStandings:  WebServiceAction { get }
}

struct StandingsServiceActionsImp: StandingsServiceActions {
    let getStandings: WebServiceAction = GetStandings()
    
    struct GetStandings: WebServiceAction {
        let path = "/v2/standings"
        let method: HTTPMethod = .get
    }
}
