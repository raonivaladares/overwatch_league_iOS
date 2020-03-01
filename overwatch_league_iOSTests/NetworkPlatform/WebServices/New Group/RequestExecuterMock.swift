import Foundation
import Combine

@testable import overwatch_league_iOS

final class RequestExecuterMock: RequestExecuter {
    enum ExpectedResult {
        case success(data: Data)
        case failure(error: NetworkPlataformError)
    }
    
    var executeInvocations = 0
    var expectedResult: ExpectedResult?
    
    func execute(with urlRquest: URLRequest) -> AnyPublisher<Data, NetworkPlataformError> {
        executeInvocations += 1
        
        return Future<Data, NetworkPlataformError> { promise in
            guard let expectedResult = self.expectedResult else { return } //TODO: Investigate finished
            
            switch expectedResult {
            case .success(let data):
                promise(.success(data))
            case .failure(let error):
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
