//		
//  Memka
//	

import Foundation

extension Models.APIResponse.Memes {
    /// A meme item cotaining general information about reddit's meme post.
    struct MemeItem: HTTPResponse {
        enum CodingKeys: String, CodingKey {
            case postLink
            case subReddit = "subreddit"
            case title
            case imageURL = "url"
            case isNSFW = "nsfw"
            case isSpoiler = "spoiler"
            case author
            case ups
            case previews = "preview"
        }
        
        /// Meme post link.
        let postLink: String
        
        /// Meme subreddit thread.
        let subReddit: String
        
        /// Meme topic title.
        let title: String
        
        /// URL to meme image.
        let imageURL: String
        
        /// Bool value indicating adult content.
        let isNSFW: Bool
        
        /// Post spoiler.
        let isSpoiler: Bool
        
        /// Post author nickname.
        let author: String
        
        /// Ups count.
        let ups: Int
        
        /// Post previews.
        let previews: [String]
    }
    
    /// An array of memes downloaded from network.
    struct MemeList: HTTPResponse {
        /// Count of memes size.
        let count: Int
        
        /// Array of meme items.
        let memes: [MemeItem]
    }
}

extension Models.APIResponse.Memes.MemeList: ResponseConvertable {
    func responseToAppModel() -> [Models.App.Memes.Meme] {
        memes.compactMap {
            // Usually we have 4 previews urls in response with different size
            guard let previewURLString = $0.previews.last, let previewURL = URL(string: previewURLString), let url = URL(string: $0.imageURL) else {
                return nil
            }
            
            return Models.App.Memes.Meme(title: $0.title, imageURL: url, previewURL: previewURL, author: $0.author, ups: $0.ups)
        }
    }
}
