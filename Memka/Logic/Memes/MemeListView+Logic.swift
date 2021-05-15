//		
//  Memka
//	

import Hydra
import Katana
import Tempura

extension Logic {
    enum MemeListView {}
}

extension Logic.MemeListView {
    /// Download memes to display on `MemeListView`.
    struct DownloadMemes: AppSideEffect {
        /// Size of memes to download.
        /// Min 1, max 50.
        ///
        /// The default value of this property is 1.
        let memeSize: Int
        
        func sideEffect(_ context: SideEffectContext<AppState, AppDependencies>) throws {
            let request = Models.APIRequest.Memes.Get(memeSize: memeSize)
            
            let loadedMemes = context.getState().memeList.memes
            var memes = [Models.App.Memes.Meme](repeating: Models.App.Memes.Meme(), count: memeSize)

            let updateMemesList = UpdateMemesList(memes: loadedMemes + memes)
            try? await(context.dispatch(updateMemesList))

            context.dependencies.networkManager.download(request: request) { (result: Result<Models.APIResponse.Memes.MemeList, ResponseError>) in
                switch result {
                case .success(let memeList):
                    memes = memeList.responseToAppModel()
                    
                    let updateMemesList = UpdateMemesList(memes: loadedMemes + memes)
                    try? await(context.dispatch(updateMemesList))
                    
                case .failure(let error):
                    print("Network download error: \(String(describing: error))")
                    return
                }
            }
        }
    }
    
    /// Update `MemeListView` with updated memes.
    private struct UpdateMemesList: AppStateUpdater {
        /// Memes to update.
        let memes: [Models.App.Memes.Meme]
        
        func updateState(_ state: inout AppState) {
            state.memeList = AppState.MemeList(memes: memes)
        }
    }

    /// Show meme details.
    struct ShowMemeDetails: AppSideEffect {
        /// The selected meme index to show on the details screen.
        let memeIndex: Int

        func sideEffect(_ context: SideEffectContext<AppState, AppDependencies>) throws {
            let localState = MemeDetailsLocalState(memeIndex: memeIndex)
            let viewModel = MemeDetailsViewModel(state: context.getState(), localState: localState)
            try await(context.dispatch(Show(AppScreen.MemeDetails, context: viewModel)))
        }
    }
}
