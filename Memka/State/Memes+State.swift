//		
//  Memka
//	

import Foundation

extension AppState {
    struct MemeList {
        /// Memes to display.
        let memes: [Models.App.Memes.Meme]
    }
}

// MARK: - Empty Initializer

extension AppState.MemeList {
    init() {
        memes = []
    }
}
