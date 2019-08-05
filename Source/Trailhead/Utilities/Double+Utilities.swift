//
//  Copyright © 2019 Matt Whitlock. All rights reserved.
//

extension Double {
    func round(toNearest: Double) -> Double {
        return (self / toNearest).rounded() * toNearest
    }
}
