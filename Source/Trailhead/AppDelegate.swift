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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
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

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

