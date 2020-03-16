import Foundation
import Combine

final class StandingsWebService {
    private let actions: StandingsServiceActionsFactory
    private let configuration: WebServiceConfiguration
    private let requestExecuter: RequestExecuter
    
    init(actions: StandingsServiceActionsFactory,
         configuration: WebServiceConfiguration,
         requestExecuter: RequestExecuter) {
        
        self.actions = actions
        self.configuration = configuration
        self.requestExecuter = requestExecuter
    }
    
    func fetchStandings() -> AnyPublisher<StandingsResponse, NetworkPlataformError> {
        
        let urlRequest = URLRequestBuilder(
            action: actions.createGetStandings(),
            configuration: configuration
        ).build()
        
        
        
        guard let request = urlRequest else {
            return Fail<StandingsResponse, NetworkPlataformError>(error: .unkown)
            .eraseToAnyPublisher()
        }
        
         return requestExecuter.execute(with: request)
        .decode(type: StandingsResponse.self, decoder: JSONDecoder())
        .mapError { error in
            if let _ = error as? DecodingError {
                return .unkown
            }
            
            return error as? NetworkPlataformError ?? .unkown
         }
        .eraseToAnyPublisher()
    }
}

//            return requestExecuter.execute(with: request)
//                .tryMap { try JSONDecoder().decode(StandingsResponse.self, from: $0) }
//                .mapError { _ in .unkown }
//                .eraseToAnyPublisher()
