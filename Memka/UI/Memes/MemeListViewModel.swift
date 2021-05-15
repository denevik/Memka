//		
//  Memka
//	

import Tempura

/// The `ViewModel` of the `MemeListView`
struct MemeListViewModel: ViewModelWithState {
    
    // MARK: - Stored Properties
    
    /// Memes to display.
    let memes: [Models.App.Memes.Meme]
    
    init?(state: AppState) {
        memes = state.memeList.memes
    }
}

extension MemeListViewModel {
    func modelForMemeListCell(at index: Int) -> MemeListCellViewModel {
        let meme = memes[index]
        
        return MemeListCellViewModel(meme: meme)
    }
}
