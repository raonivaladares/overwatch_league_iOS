import Foundation

final class URLResponseErrorParser {
    func parseErrorIfExists(on response: URLResponse) -> NetworkPlataformError? {
        guard let response = response as? HTTPURLResponse else {
            return NetworkPlataformError.unkown
        }
        
        switch response.statusCode {
        case 200...299:
            return nil
        default:
            return NetworkPlataformError.unkown
        }
    }
}

