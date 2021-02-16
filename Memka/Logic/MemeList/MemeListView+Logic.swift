//		
//  Memka
//	

import Katana

extension Logic {
  enum MemeListView {}
}

extension Logic.MemeListView {
  /// Download memes to display on `MemeListView`.
  struct DownloadMemes: AppSideEffect {
    func sideEffect(_ context: SideEffectContext<AppState, AppDependencies>) throws {
      guard let url = URL(string: "https://meme-api.herokuapp.com/gimme/memes/50") else {
        return
      }

      var memes = [Models.App.MemeList.Meme]()
      URLSession.shared.dataTask(with: url) { data, response, error in
        guard error == nil else {
          print("Download memes error: \(String(describing: error))")
          return
        }

        do {
          let memesList = try JSONDecoder().decode(Models.App.MemeList.MemeList.self, from: data!)

          memesList.memes.forEach { memeItem in
            guard let imageURL = URL(string: memeItem.url) else {
              return
            }

            URLSession.shared.dataTask(with: imageURL) { data, response, error in
              guard error == nil else {
                print("Download meme iamge error: \(String(describing: error))")
                return
              }

              guard let image = UIImage(data: data!) else {
                return
              }

              let meme = Models.App.MemeList.Meme(title: memeItem.title, image: image)
              memes.append(meme)

              let updateMemesList = UpdateMemesList(memes: memes)
              context.dispatch(updateMemesList)
            }.resume()
          }
        } catch {
          print("Parsing error: \(error)")
        }
      }.resume()
    }
  }

  /// Update `MemeListView` with updated memes.
  private struct UpdateMemesList: AppStateUpdater {
    /// Memes to display.
    let memes: [Models.App.MemeList.Meme]

    func updateState(_ state: inout AppState) {
      state.memeList = AppState.MemeList(memes: memes)
    }
  }
}
