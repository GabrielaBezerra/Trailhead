//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import UIKit

/// Implements `Coordinator` protocol and is responsible for the overall app coordinator functionality.
class AppCoordinator: Coordinator, AppStatusInjectable, AppDataInjectable, DependencyManagerInjectable {
    var childCoordinator: Coordinator?
    weak var delegate: CoordinatorDelegate?
    let navigationController: UINavigationController

    var appStatus: AppStatus! = nil
    var appData: AppData! = nil
    var dependencyManager: DependencyManager! = nil

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func checkForNil() {
        assert(appStatus != nil)
        assert(appData != nil)
        assert(dependencyManager != nil)
    }

    func start() {
        // Determine what screen to instantiate and move to it.

        moveToHomeViewController()
    }

    func finish() {
        childCoordinator = nil
    }
}

// MARK: - Handle view controller delegates
extension AppCoordinator: HomeNavigationDelegate {

}

// MARK: - View controller instantiation logic
// Using separate functions to allow reuse and single place to handle all dependency injection
// Otherwise would just use xyzViewController.instantiate()
extension AppCoordinator {
    /// Instantiate, inject, and move to the home view controller
    func moveToHomeViewController() {
        let homeViewController = HomeViewController.instantiate()
        homeViewController.navigationDelegate = self

        dependencyManager.inject(homeViewController)
        dependencyManager.inject(homeViewController.homeViewModel)

        moveToScreen(homeViewController)
    }
}
