//		
//  Memka
//	

import Foundation

/// Name spacing models.
enum Models {
    // In case if need analytics
    // I don't have any, just an example.
    enum Analytics {}
    
    enum APIResponse {}
    
    enum APIRequest {}
    
    enum App {}
}

extension Models.App {
    /// Name spacing `Memes` related models.
    enum Memes {}
}

extension Models.APIRequest {
    /// Name spacing `Memes` related `APIRequest` models.
    enum Memes {}
}

extension Models.APIResponse {
    /// Name spacing `Memes` related `APIResponse` models.
    enum Memes {}
}
