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
        let dependencyManager = DependencyManager()
        let test = TestInjectableClass()

        dependencyManager.inject(test)
    }

    func testDependencyManagerWithAppStatusMock() {
        let appStatusMock = AppStatusMock()
        appStatusMock.appState = .error
        appStatusMock.bleConnected.accept(true)

        let dependencyManager = DependencyManager(appStatus: appStatusMock)
        let test = TestInjectableClass()
        dependencyManager.inject(test)

        // Ensure injected mock class:
        XCTAssert(test.appStatus! is AppStatusMock)

        XCTAssertEqual(test.appStatus.appState, .error)
        XCTAssertTrue(test.appStatus.bleConnected.value)
    }

}
