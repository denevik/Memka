//		
//  Memka
//	

import Tempura

/// The `ViewModel` of the `MemeDetailsView`
struct MemeDetailsViewModel: ViewModelWithLocalState {
    /// Meme with data to dispay.
    let meme: Models.App.Memes.Meme

    init?(state: AppState?, localState: MemeDetailsLocalState) {
        guard let state = state, state.memeList.memes.indices.contains(localState.memeIndex) else {
          return nil
        }

        meme = state.memeList.memes[localState.memeIndex]
    }
}


struct MemeDetailsLocalState: LocalState {
    /// The selected meme index to show on the details screen.
    let memeIndex: Int
}
