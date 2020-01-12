struct WebServiceActions {
    private init() {}
    
    struct GetStandings: WebServiceAction {
        let path = "/v2/standings"
        let method: HTTPMethod = .get
    }
}
