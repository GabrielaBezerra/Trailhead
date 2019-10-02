//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import UIKit

/// :nodoc:

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    /// Top level App Coordinator
    ///
    /// Reference held here so top level coordinator stays in memory.
    var appCoordinator: AppCoordinator?
    /// Base window for the application
    ///
    /// Reference held here so that it stays in memory
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Don't run UI if unit testing:
        if NSClassFromString("XCTest") != nil {
            return true
        }

        window = UIWindow() // Assign to AppDelegate to ensure Window doesn't go away.

        // Create navigation controller and attach it to the window.
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = false
        navigationController.navigationBar.tintColor = .black

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible() // Make Window (with navigationController) key and visible (i.e. show window)

        // Create/Start App Coordinator and give it the navigation controller.
        appCoordinator = AppCoordinator(navigationController: navigationController)
        guard let appCoordinator = appCoordinator else {
            assertionFailure("AppCoordinator not properly initialized.")
            return false
        }

        // Dependency manager can be a local variable as once it's passed into
        // the AppCoordinator, it is no longer needed here. AppCoordinator will
        // hold onto the reference.
        let dependencyManager = DependencyManager()
        dependencyManager.inject(appCoordinator)

        appCoordinator.delegate = nil // AppCoordinator doesn't have anything to report.
        appCoordinator.start()

        return true
    }

}
