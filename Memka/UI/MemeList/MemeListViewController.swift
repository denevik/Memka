//		
//  Memka
//	

import Tempura

/// The `ViewController` managing the root `MemeList` view.
class MemeListViewController: ViewController<MemeListView>, RoutableWithConfiguration {
  var routeIdentifier: RouteElementIdentifier {
    AppScreen.MemeList.rawValue
  }

  var navigationConfiguration: [NavigationRequest: NavigationInstruction] {
    return [:]
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    dispatch(Logic.MemeListView.DownloadMemes())
  }
}
