//
//  Copyright © 2019 Matt Whitlock. All rights reserved.
//

import UIKit

extension UIButton {
    /// Make button with fully rounded ends
    func makeRounded() {
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = true
    }

    /// Round corners of button.
    ///
    /// - Parameter radius: radius of rounding; if nil, round 25% of height.
    func makeRoundedCorner(withRadius radius: CGFloat? = nil) {
        if let radius = radius {
            layer.cornerRadius = radius
        } else {
            layer.cornerRadius = layer.bounds.height * 0.25
        }
        layer.masksToBounds = true
    }
}
