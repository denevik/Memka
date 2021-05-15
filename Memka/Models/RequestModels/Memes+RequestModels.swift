//		
//  Memka
//	

import Foundation

extension Models.APIRequest.Memes {
    /// The body for the `Memes.Get` request.
    struct Get: HTTPRequest {
        /// URL for resource to download.
        var url: URL {
            return URL(string: "https://meme-api.herokuapp.com/gimme/memes/\(memeSize)")!
        }
        
        /// Size of memes to download.
        /// Min 1, max 50.
        ///
        /// The default value of this property is 1.
        let memeSize: Int
        
        init(memeSize: Int = 1) {
            self.memeSize = memeSize >= 1 && memeSize <= 50 ? memeSize : 1
        }
    }
}
