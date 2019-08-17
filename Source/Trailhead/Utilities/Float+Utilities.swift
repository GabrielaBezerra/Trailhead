//
//  Copyright © 2019 Matt Whitlock. All rights reserved.
//

// FIXME: Change to generic to work with BinaryFloatingPoint
extension Float {
    /// Rounds to the nearest multiple of input
    ///
    /// - Parameter: Interval to round to
    /// - Returns: Rounded value
    func toNearest(_ interval: Float) -> Float {
        return (self / interval).rounded() * interval
    }
    
    /// Test for equality within tolerance
    ///
    /// - Parameters:
    ///   - tolerance: tolerance to test to
    ///   - value: value to test against
    /// - Returns: true if within tolerance
    func within(_ tolerance: Float, of value: Float) -> Bool {
        if tolerance <= 1e-10 { return false }
        return abs(self - value) <= tolerance
    }
    
}
