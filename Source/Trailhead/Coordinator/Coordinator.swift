//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import UIKit

/// Coordinator Protocol
///
/// Establishes baseline functionality shared by all coordinators.
///
/// * Coordinators are designed to work with other coordinators in a hierarchy.
/// * It is common and expected for a coordinator to pass responsibility to a child coordinator.
/// * For example an onboarding workflow should be handled by its own coordinator.
/// * Login / account signup workflow is another example.
///
/// Move to screen functionality implemented in protocol extension.
protocol Coordinator: AppStatusInjectable, AppDataInjectable {
    /// The active child coordinator if any.
    var childCoordinator: Coordinator? { get set }
    
    /// Delegate for this coordinator.
    ///
    /// Typically the parent coordinator.
    var delegate: CoordinatorDelegate? { get set }
    
    /// Reference to the navigation controller shared by the app and all coordinators.
    var navigationController: UINavigationController { get }

    /// Initializer for coordinator
    ///
    /// - Parameter navigationController: reference to the shared navigation controller
    init(navigationController: UINavigationController)

    /// Indication to start the coordinator
    ///
    /// Typically called after setting the delegate on the coordinator
    /// and doing dependency injection.
    func start()
    
    /// Finish this coordinator by doing any necessary cleanup.
    ///
    /// Typically called when the natural flow of the coordinator ends.
    /// ex. For a login flow, if login is successful, a viewcontroller will
    /// notify (via delegate method to this coordinator) of success, and that
    /// method should call finish()
    func finish()
}

/// CoordinatorDelegate protocol
protocol CoordinatorDelegate {
    /// Designate to parent coordinator (usually) that flow has been finished
    ///
    /// - Parameters:
    ///   - coordinator: coordinator for which flow is finished.
    ///     Used so that parent can have many child coordinators and one flowFinished
    ///     handler.
    ///   - nextScreen: requested next screen if any.
    func finished(_ coordinator: Coordinator, nextScreen: Screen?)
}

extension Coordinator {
    /// Determines whether view controller needs to be popped off the navigation stack.
    ///
    /// - Parameter viewController: viewcontroller to pop if desired.
    private func popIfDesired(_ viewController: Coordinatable) {
        if viewController.popsOnDismiss {
            navigationController.popViewController(animated: false)
        }
    }
    
    /// Moves to the specified view controller using the built-in navigation controller.
    ///
    /// - Parameters:
    ///   - viewController: instantiated view controller (Coordinatable) to move to
    func moveToScreen(_ viewController: Coordinatable) {
        popIfDesired(viewController)
        navigationController.setToolbarHidden(!viewController.showsNavigationBar, animated: false)
        navigationController.pushViewController(viewController, animated: true)
    }

    /// Moves back in the navigation stack to the specified view controller.
    ///
    /// - Parameters:
    ///   - viewController: view controller (Coordinatable) to move back in the stack to
    /// - Throws: throws CoordinatorError.controllerNotInStack if the controller is not found in the navigation stack
    func returnToScreen(_ viewController: Coordinatable) throws {
        guard navigationController.viewControllers.contains(viewController) else {
            throw CoordinatorError.controllerNotInStack
        }
        popIfDesired(viewController)
        navigationController.popToViewController(viewController, animated: true)
        navigationController.setToolbarHidden(!viewController.showsNavigationBar, animated: false)
    }

    /// Moves back in the navigation stack to the previous view controller
    func popScreen() {
        navigationController.popViewController(animated: true)
        if let viewController = navigationController.topViewController as? Coordinatable {
            popIfDesired(viewController)
            navigationController.setToolbarHidden(!viewController.showsNavigationBar, animated: false)
        }
    }

    /// Returns to the home aka root view controller
    func returnToHome() {
        navigationController.popToRootViewController(animated: true)
        if let viewController = navigationController.topViewController as? Coordinatable {
            popIfDesired(viewController)
            navigationController.setToolbarHidden(!viewController.showsNavigationBar, animated: false)
        }

    }
}

/// Errors that may be thrown by the Coordinator
enum CoordinatorError: Error {
    /// Controller was not found in the navigation stack.
    case controllerNotInStack

    /// Text description of the error
    var errorDescription: String? {
        switch self {
        case .controllerNotInStack:
            return "Tried to return to view controller not in view stack"
        }
    }
}
