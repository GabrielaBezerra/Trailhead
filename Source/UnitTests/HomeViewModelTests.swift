//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import XCTest
@testable import Trailhead

class HomeViewModelTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInstantiatesWithoutDependencies() {
        let homeViewModel = HomeViewModel()
        XCTAssertNil(homeViewModel.appData)
        XCTAssertNil(homeViewModel.appStatus)
    }

    func testTitleDefault() {
        let homeViewModel = HomeViewModel()
        XCTAssertEqual(homeViewModel.screenTitle.value, "Home")
    }

    func testEULAAcceptedUpdatesAppData() {
        let homeViewModel = HomeViewModel()
        // Set appData manually to avoid dependency manager entanglements at this point.
        homeViewModel.appData = AppData()
        XCTAssertFalse(homeViewModel.appData.eulaAccepted.value)

        homeViewModel.eulaAccepted(true)
        XCTAssertTrue(homeViewModel.appData.eulaAccepted.value)

        homeViewModel.eulaAccepted(false)
        XCTAssertFalse(homeViewModel.appData.eulaAccepted.value)
    }

    // MARK: - Test Rx bits
    // FIXME: Test Rx.

    // MARK: - With Dependency Manager
    func testDependencyManagerInjectsDefaultsProperly() {
        let homeViewModel = HomeViewModel()
        let dependencyManager = DependencyManager()
        dependencyManager.inject(homeViewModel)

        XCTAssertNotNil(homeViewModel.appData)
        XCTAssertNotNil(homeViewModel.appStatus)
    }

}
