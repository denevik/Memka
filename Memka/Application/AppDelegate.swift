//		
//  Memka
//	

import Katana
import Tempura

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var store: Store<AppState, AppDependencies>!
    
    // MARK: - Computed Properties
    
    /// The list of observers to pass to the `Store`.
    private var observers: [ObserverInterceptor.ObserverType] {
        return []
    }
    
    /// Interceptors used by the store.
    private var storeInterceptors: [StoreInterceptor] {
        return [
            ObserverInterceptor.observe(self.observers)
        ]
    }
    
    // MARK: - Private Helpers
    
    private func instantiateStore() -> Store<AppState, AppDependencies> {
        Store<AppState, AppDependencies>(interceptors: storeInterceptors)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = self.window ?? UIWindow(frame: UIScreen.main.bounds)
        
        guard let window = window else {
            fatalError("No window")
        }
        
        store = instantiateStore()
        store.dependencies.navigator.start(using: self, in: window, at: AppScreen.MemeList)
        
        return true
    }
}

extension AppDelegate: RootInstaller {
    
    func installRoot(identifier: RouteElementIdentifier, context: Any?, completion: () -> ()) -> Bool {
        let viewController = MemeListViewController(store: self.store)
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        
        completion()
        
        return true
    }
}
