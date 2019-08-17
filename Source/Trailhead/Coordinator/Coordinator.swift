//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import UIKit

/// Coordinator Protocol
protocol Coordinator: AppStatusInjectable, AppDataInjectable {
    var childCoordinator: Coordinator? { get set }
    var delegate: CoordinatorDelegate? { get set }
    var navigationController: UINavigationController { get }

    init(navigationController: UINavigationController)

    func start()
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
    func moveToScreen(_ viewController: UIViewController, showNavigationBar: Bool) {
        navigationController.setToolbarHidden(!showNavigationBar, animated: false)
        navigationController.pushViewController(viewController, animated: true)
    }

    func returnToScreen(_ viewController: UIViewController, showNavigationBar: Bool) throws {
        navigationController.setToolbarHidden(!showNavigationBar, animated: false)
        guard navigationController.viewControllers.contains(viewController) else {
            throw CoordinatorError.controllerNotInStack
        }
        navigationController.popToViewController(viewController, animated: true)
    }

    func popScreen(showNavigationBar: Bool) {
        navigationController.setToolbarHidden(!showNavigationBar, animated: false)
        navigationController.popViewController(animated: true)
    }

    func returnToHome(showNavigationBar: Bool) {
        navigationController.setToolbarHidden(!showNavigationBar, animated: false)
        navigationController.popToRootViewController(animated: true)
    }
}

enum CoordinatorError: Error {
    case controllerNotInStack

    var errorDescription: String? {
        switch self {
        case .controllerNotInStack:
            return "Tried to return to view controller not in view stack"
        }
    }
}
