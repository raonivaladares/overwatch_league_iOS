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
    func execute(
        with urlRquest: URLRequest,
        completion: @escaping (Result<Data, NetworkPlataformError>) -> Void) {
        
        let session = URLSession.shared
        
        session.dataTask(with: urlRquest) { data, urlResponse, error in
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
        }.resume()
    }
        
//        session.dataTask (with: url) { data, response, error in
//            print("Entered the completionHandler")
//            guard let httpResponse = response as? HTTPURLResponse else {
//                return
//            }
////            print("Request with url: \(components.url!)")
//            print("Request result: \(httpResponse.statusCode)")
//            print("Request response: \(response)")
//
//        }.resume()
//    }
}


