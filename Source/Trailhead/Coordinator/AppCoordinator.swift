//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator, AppStatusInjectable, AppDataInjectable, DependencyManagerInjectable {
    var childCoordinator: Coordinator? = nil
    var delegate: CoordinatorDelegate? = nil
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

    func moveToNext() {

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
    func moveToHomeViewController() {
        let homeViewController = HomeViewController.instantiate()
        homeViewController.navigationDelegate = self

        dependencyManager.inject(homeViewController)
        dependencyManager.inject(homeViewController.homeViewModel)

        moveToScreen(homeViewController, showNavigationBar: false)
    }
}
