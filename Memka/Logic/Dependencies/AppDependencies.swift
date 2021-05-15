//
//  Memka
//	

import Katana
import Tempura

final class AppDependencies: SideEffectDependencyContainer, NavigationProvider {

    // MARK: - Properties

    /// The state of the app.
    var state: () -> AppState

    /// The `Tempura` navigator.
    var navigator: Navigator

    /// The network calls manager.
    var networkManager: NetworkManager

    init(dispatch: @escaping AnyDispatch, getAppState: @escaping () -> AppState) {
        self.state = getAppState
        self.networkManager = NetworkManager.shared
        self.navigator = Navigator()
    }
}

extension AppDependencies {
    convenience init(dispatch: @escaping AnyDispatch, getState: @escaping GetState) {
        let getAppState: () -> AppState = {
            guard let state = getState() as? AppState else {
                print("Error casting \(GetState.self) to \(AppState.self)")
                return AppState()
            }
            return state
        }
        
        self.init(dispatch: dispatch, getAppState: getAppState)
    }
}

extension AppDependencies {
    convenience init(dispatch: @escaping AnyDispatch, getAppState: @escaping () -> AppState, navigator: Navigator, networkManager: NetworkManager = NetworkManager.shared) {
        self.init(dispatch: dispatch, getState: getAppState)
        self.state = getAppState
        self.networkManager = networkManager
        self.navigator = navigator
    }
}
