import Foundation

final class StandingsWebService {
    private let actions: StandingsServiceActions
    private let configuration: WebServiceConfiguration
    private let requestExecuter: RequestExecuter
    
    init(actions: StandingsServiceActions,
        configuration: WebServiceConfiguration,
        requestExecuter: RequestExecuter) {
        
        self.actions = actions
        self.configuration = configuration
        self.requestExecuter = requestExecuter
    }
    
    func fetchStandings(
        completion: @escaping (Result<StandingsResponse, NetworkPlataformError>) -> Void) {
        
        let urlRequest = URLRequestBuilder(
            action: actions.getStandings,
            configuration: configuration
        ).build()
        
        guard let request = urlRequest else {
            completion(.failure(.unkown))
            return
        }
        
        requestExecuter.execute(with: request) { result in
            switch result {
            case .success(let data):
                guard let standingsResponse = try? JSONDecoder()
                    .decode(StandingsResponse.self, from: data) else {
                        completion(.failure(.unkown))
                        return
                }
                
                completion(.success(standingsResponse))
                
            case .failure(let error):
                completion(.failure(.unkown))
            }
        }
    }
}
