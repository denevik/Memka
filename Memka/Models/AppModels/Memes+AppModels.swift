//		
//  Memka
//	

import UIKit

extension Models.App.Memes {
    /// The meme object containing information of reddit's meme topic and image.
    struct Meme: Equatable {
        /// Meme topic from reddit's post.
        let title: String?
        
        /// Meme image from reddit's post.
        let imageURL: URL?

        /// Post preview from reddit's post..
        let previewURL: URL?

        /// Post author nickname from reddit.
        let author: String?

        /// Ups count from reddit's post.
        let ups: Int?

        init(title: String? = nil, imageURL: URL? = nil, previewURL: URL? = nil, author: String? = nil, ups: Int? = nil) {
            self.title = title
            self.imageURL = imageURL
            self.previewURL = previewURL
            self.author = author
            self.ups = ups
        }

        static func == (lhs: Meme, rhs: Meme) -> Bool {
            return lhs.author == rhs.author
                && lhs.title == rhs.title
                && lhs.previewURL == rhs.previewURL
        }
    }
}
