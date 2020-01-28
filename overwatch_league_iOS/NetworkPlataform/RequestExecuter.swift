import Foundation

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
            if let error = error {
                print("--------------------------")
                print("error")
                print(error)
                print("--------------------------")
                
                completion(.failure(.unkown))
            }
            
            guard let urlResponse = urlResponse  else {
                completion(.failure(.unkown))
                return
            }
            
            print("--------------------------")
            print("urlResponse")
            print(urlResponse)
            print("--------------------------")
            
            if let errorFromURLResponse = URLResponseErrorParser()
                .parseErrorIfExists(on: urlResponse) {
                
                completion(.failure(errorFromURLResponse))
                return
            }
        
            if let data = data {
                print("--------------------------")
                print("DATA")
                print(data)
                print("--------------------------")
                completion(.success(data))
            } else {
                completion(.failure(.unkown))
            }
        }.resume()
    }
}
