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
        return [
            .show(AppScreen.MemeDetails): .push { context in
                guard let viewModel = context as? MemeDetailsViewModel else {
                    // Mock, should return errorScreen/root app screen/restart etc
                    return UIViewController()
                }

                let viewController = MemeDetailsViewController(store: self.store, localState: MemeDetailsLocalState(memeIndex: -1))
                viewController.viewModel = viewModel
                return viewController
            }
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dispatch(Logic.MemeListView.DownloadMemes(memeSize: 20))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }
    
    override func setupInteraction() {
        super.setupInteraction()
        
        rootView.prefetchMemesAction = { [weak self] in
            self?.dispatch(Logic.MemeListView.DownloadMemes(memeSize: 25))
        }

        rootView.didSelectMeme = { [weak self] index in
            self?.dispatch(Logic.MemeListView.ShowMemeDetails(memeIndex: index))
        }
    }
}
