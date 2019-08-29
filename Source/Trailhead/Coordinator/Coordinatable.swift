//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//
import UIKit

/// Coordinatable is for UIViewControllers that will be managed by a coordinator.
protocol Coordinatable where Self: UIViewController {
    /// Whether the screen should show the navigation bar or not.
    ///
    /// Detail screens that need a back button should be set to true.
    var showsNavigationBar: Bool { get }
    
    /// Whether to pop the screen off the navigation stack when moving away from it.
    ///
    /// Screens that are part of the main interaction of app generally should be false.
    /// One-time screens (startup, onboarding, etc) probably should be true.
    var popsOnDismiss: Bool { get }
}
