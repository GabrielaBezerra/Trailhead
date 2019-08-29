//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import XCTest
@testable import Trailhead

class DependencyManagerTests: XCTestCase {
    // No setup/teardown code.
    class TestInjectableClass: AppStatusInjectable {
        var appStatus: AppStatus!

        func checkForNil() {
            XCTAssertNotNil(appStatus)
        }
    }

    class AppStatusMock: AppStatus {
    }

    func testDependencyManagerDefaultConstructor() {
        // Testing that the dependency manager constructor works
        _ = DependencyManager()
    }

    func testDependencyManagerWithAppStatusMock() {
        let appStatusMock = AppStatusMock()
        appStatusMock.appState.accept(.error)
        appStatusMock.bleConnected.accept(true)

        let dependencyManager = DependencyManager(appStatus: appStatusMock)
        let test = TestInjectableClass()
        dependencyManager.inject(test)

        // Ensure injected mock class:
        XCTAssert(test.appStatus! is AppStatusMock)

        XCTAssertEqual(test.appStatus.appState.value, .error)
        XCTAssertTrue(test.appStatus.bleConnected.value)
    }

    func testDependencyManagerInjectSelf() {
        /// Class only used for this test.
        class testDependencyManagerClass: DependencyManagerInjectable {
            var dependencyManager: DependencyManager!
        }
        
        let dependencyManager = DependencyManager()
        let test = testDependencyManagerClass()
        dependencyManager.inject(test)
        
        XCTAssert(test.dependencyManager === dependencyManager)
    }
}
