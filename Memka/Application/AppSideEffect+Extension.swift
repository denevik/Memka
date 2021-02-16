//
//  Memka
//

import Katana

/// A `SideEffect` wrapper to get better completion.
protocol AppSideEffect: SideEffect where StateType == AppState, Dependencies == AppDependencies {}
