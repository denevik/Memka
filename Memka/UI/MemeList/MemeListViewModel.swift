//		
//  Memka
//	

import Tempura

/// The `ViewModel` of the `MemeListView`
struct MemeListViewModel: ViewModelWithState {

  // MARK: - Stored Properties

  /// Memes to display.
  let memes: [Models.App.MemeList.Meme]

	init?(state: AppState) {
    memes = state.memeList.memes
  }
}
