//		
//  Memka
//	

import UIKit

extension Models.App.MemeList {
  /// The meme object containing information link to reddit meme and images.
  struct Meme: Hashable {
    let title: String
    let image: UIImage
  }

  struct MemeItem: Decodable {
    let postLink: String
    let subreddit: String
    let title: String
    let url: String
    let nsfw: Bool
    let spoiler: Bool
    let author: String
    let ups: Int
    let preview: [String]
  }
  
  /// An array of memes downloaded from network.
  struct MemeList: Decodable {
    let count: Int
    let memes: [MemeItem]
  }
}
