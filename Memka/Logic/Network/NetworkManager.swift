//		
//  Memka
//	

import Foundation

/// Converts server response to related app model.
protocol ResponseConvertable {
    associatedtype Model
    
    func responseToAppModel() -> Model
}

protocol HTTPRequest {
    /// URL for resource to download.
    var url: URL { get }
}
protocol HTTPResponse: Decodable {}

enum ResponseError: Error {
    case network
    case parsing
}

/// Manage network requests. Has to be in a separate framework.
/// Don't mind on that as it's just an example of Redux architecture.
class NetworkManager {
    
    static let shared = NetworkManager()
    
    /// Download requests from the network.
    func download<Request: HTTPRequest, Response: HTTPResponse>(request: Request, completion: @escaping (Result<Response, ResponseError>) -> Void) {
        URLSession.shared.dataTask(with: request.url) { data, response, error in
            guard error == nil else {
                completion(.failure(.network))
                return
            }
            
            do {
                let responseData = try JSONDecoder().decode(Response.self, from: data!)
                completion(.success(responseData))
            } catch {
                print("Parsing error: \(error)")
                completion(.failure(.parsing))
            }
        }.resume()
    }
}

