import Foundation
import Combine

protocol RequestExecuter {
    func execute(with urlRquest: URLRequest) -> AnyPublisher<Data, NetworkPlataformError>
}

final class RequestExecuterImp: RequestExecuter {
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func execute(with urlRquest: URLRequest) -> AnyPublisher<Data, NetworkPlataformError> {
        return urlSession
            .dataTaskPublisher(for: urlRquest)
            .tryMap { data, response in
                
                print("--------------------------")
                print("urlResponse")
                print(response)
                print("--------------------------")
                if let error = URLResponseErrorParser().parseErrorIfExists(on: response) {
                    throw error
                }
                print("--------------------------")
                print("DATA")
                print(data)
                print("--------------------------")
                
                return data
            }
            .mapError { error in
                print("--------------------------")
                print("error maping")
                print(error)
                print("--------------------------")
                return .unkown
            }
            .eraseToAnyPublisher()
    }
}
