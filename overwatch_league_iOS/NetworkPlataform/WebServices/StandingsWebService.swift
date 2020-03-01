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
    
    func fetchStandings(
        completion: @escaping (Result<StandingsResponse, NetworkPlataformError>) -> Void) {
        
        let urlRequest = URLRequestBuilder(
            action: actions.createGetStandings(),
            configuration: configuration
        ).build()
        
        guard let request = urlRequest else {
            completion(.failure(.unkown))
            return
        }
        
        let publisher = requestExecuter.execute(with: request)
        
        _ = publisher.sink(receiveCompletion: { subscribeCompletion in
            switch subscribeCompletion {
            case .failure(let error):
                print("sink error: \(error)")
                completion(.failure(error))
            case .finished:
                print("sink fechou")
                break
                
            }
        }, receiveValue: { data in
            guard let standingsResponse = try? JSONDecoder()
                .decode(StandingsResponse.self, from: data) else {
                    completion(.failure(.unkown))
                    return
            }
            
            completion(.success(standingsResponse))
            
        })
        
//        requestExecuter.execute(with: request) { result in
//            switch result {
//            case .success(let data):
//                guard let standingsResponse = try? JSONDecoder()
//                    .decode(StandingsResponse.self, from: data) else {
//                        completion(.failure(.unkown))
//                        return
//                }
//
//                completion(.success(standingsResponse))
//
//            case .failure(let error):
//                completion(.failure(.unkown))
//            }
//        }
    }
}

//final class StandingsSubscriber: Subscriber {
//    typealias Input = Data
//    typealias Failure = NetworkPlataformError
//
//    func receive(subscription: Subscription) {
//        subscription.request(.unlimited)
//    }
//
//    func receive(_ input: Data) -> Subscribers.Demand {
//
//    }
//
//    func receive(completion: Subscribers.Completion<NetworkPlataformError>) {
//
//    }
//}
