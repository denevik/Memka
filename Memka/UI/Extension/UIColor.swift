//
//  Memka
//

import UIKit

extension UIColor {

    private static func random255() -> CGFloat {
        CGFloat(arc4random()) / CGFloat(UInt32.max)
    }

    static var random: UIColor {
        return UIColor(
            red:   random255(),
            green: random255(),
            blue:  random255(),
            alpha: 1.0
        )
    }
}
