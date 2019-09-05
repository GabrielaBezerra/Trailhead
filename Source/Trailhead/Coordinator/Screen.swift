//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//
import UIKit
/// Represent all screens in an app.
///
/// Often used by Coordinators to represent next screen
/// to move to after ending a coordinator via finished()
enum Screen {
    /// Onboarding flow
    case onboarding // example
    /// Login flow
    case login // example
    /// Home screen
    case home
}

// TODO: Add declarative syntax for screens.
//    One way would be to have array of screens in typical order and
//    use that to go back and next. Enum may be a better option.

// Also would be good to have declarative way to determine whether to show
// NavigationBar or not. Currently this is within the view controller itself.
// Also pop from navigatin controller or not.

//protocol NavBarHandler {
//    var showNavigationBar: Bool { get }
//}
