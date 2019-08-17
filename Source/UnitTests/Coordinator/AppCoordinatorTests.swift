//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import XCTest
@testable import Trailhead

class AppCoordinatorTests: XCTestCase {
    let dependencyManager = DependencyManager()

    func testAppCoordinatorInstantiation() {
        let navigationController = UINavigationController()

        let appCoordinator = AppCoordinator(navigationController: navigationController)
        
        // AppCoordinator is long-lived, nothing to delegate.
        XCTAssertNil(appCoordinator.delegate)
    }
    
    func testAppCoordinatorStartMovesToHomeViewController() {
        let navigationController = UINavigationController()
        let appCoordinator = AppCoordinator(navigationController: navigationController)

        dependencyManager.inject(appCoordinator)
        
        // No view controller to before start().
        XCTAssertTrue(navigationController.viewControllers.isEmpty)

        appCoordinator.start()
        XCTAssertFalse(navigationController.viewControllers.isEmpty)
        
        XCTAssertNotNil(navigationController.viewControllers.first as? HomeViewController)
    }
}
