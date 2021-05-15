//		
//  Memka
//	

import Tempura

/// The `ViewController` managing the root `MemeDetails` view.
class MemeDetailsViewController: ViewControllerWithLocalState<MemeDetailsView>, RoutableWithConfiguration {
    var routeIdentifier: RouteElementIdentifier {
        AppScreen.MemeDetails.rawValue
    }

    var navigationConfiguration: [NavigationRequest: NavigationInstruction] {
        return [
            .hide(AppScreen.MemeDetails): .pop
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = false
    }
}
