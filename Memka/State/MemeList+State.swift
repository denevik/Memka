//		
//  Memka
//	

import Foundation

extension AppState {
  struct MemeList {
    /// Memes to display.
    let memes: [Models.App.MemeList.Meme]
  }
}

// MARK: - Empty Initializer

extension AppState.MemeList {
  init() {
    memes = []
  }
}
