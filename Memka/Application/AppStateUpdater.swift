//
//  Memka
//

import Katana

/// A `StateUpdater` wrapper to get better completion.
protocol AppStateUpdater: StateUpdater where StateType == AppState {}
