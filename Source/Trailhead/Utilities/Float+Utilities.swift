//
//  Copyright © 2019 Matt Whitlock. All rights reserved.
//

extension Float {
    func round(toNearest: Float) -> Float {
        return (self / toNearest).rounded() * toNearest
    }
}
