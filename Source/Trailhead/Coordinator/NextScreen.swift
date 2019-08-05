//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

/// Next screen to move to after ending a coordinator via finished()
enum NextScreen {
    case onboarding
    case home
}

// TODO: Add declarative syntax for screens.
//    One way would be to have array of screens in typical order and
//    use that to go back and next. Enum may be a better option.

// Also would be good to have declarative way to determine whether to show
// NavigationBar or not.
