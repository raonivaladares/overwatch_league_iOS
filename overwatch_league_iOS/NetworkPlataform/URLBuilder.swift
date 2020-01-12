import Foundation

final class URLRequestBuilder {
    private let action: WebServiceAction
    private let configuration: WebServiceConfiguration
    
    init(action: WebServiceAction,
         configuration: WebServiceConfiguration) {
        
        self.action = action
        self.configuration = configuration
    }
    
    func build() -> URLRequest? {
        let components = createURLComponets()
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = action.method.rawValue
        
        return urlRequest
    }
    
    private func createURLComponets() -> URLComponents {
        var components = URLComponents()
        components.scheme = configuration.scheme
        components.host = configuration.host
        components.path = action.path
        
        return components
    }
}
