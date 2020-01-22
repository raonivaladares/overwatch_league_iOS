import Foundation

enum NetworkPlataformError: Error {
    case unkown
}

protocol RequestExecuter {
    func execute(
        with url: URLRequest,
        completion: @escaping (Result<Data, NetworkPlataformError>) -> Void
    )
}

final class RequestExecuterImp: RequestExecuter {
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func execute(
        with urlRquest: URLRequest,
        completion: @escaping (Result<Data, NetworkPlataformError>) -> Void) {
        
        urlSession.dataTask(with: urlRquest) { data, urlResponse, error in
            if let data = data {
                print("--------------------------")
                print("DATA")
                print(data)
                print("--------------------------")
            }
            
            if let urlResponse = urlResponse {
                print("--------------------------")
                print("urlResponse")
                print(urlResponse)
                print("--------------------------")
            }
            
            if let error = error {
                print("--------------------------")
                print("error")
                print(error)
                print("--------------------------")
            }
            completion(.failure(.unkown))
        }.resume()
    }
    
    private func parseResponse(response: URLResponse) -> NetworkPlataformrError? {
        if let response = response as? HTTPURLResponse {
            switch response.statusCode {
            case 200...299:
                return nil
            default:
                return NetworkPlataformrError.unkown
            }
        }
        
        return NetworkPlataformrError.unkown
    }
}

final class urlResponseErrorParser {
    init() {
        
    }
}
