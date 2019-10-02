//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import XCTest
@testable import Trailhead

class DoubleUtilitiesTests: XCTestCase {
    func testWithin() {
        XCTAssertTrue(0.5.within(0.5, of: 1.0))
        XCTAssertFalse(0.5.within(0.4999, of: 1.0))

        XCTAssertTrue(1.5.within(0.5, of: 1.0))
        XCTAssertFalse(1.5.within(0.4999, of: 1.0))

        XCTAssertFalse(0.5.within(0.0, of: 0.5))
    }

    func testRoundTo1() {
        XCTAssertTrue(0.5.toNearest(1.0).within(1e-3, of: 1.0))
        XCTAssertTrue(1.5.toNearest(1.0).within(1e-3, of: 2.0))
        XCTAssertTrue(1.4.toNearest(1.0).within(1e-3, of: 1.0))
    }
    func testRoundTo10() {
        XCTAssertTrue(0.5.toNearest(10.0).within(1e-3, of: 0.0))
        XCTAssertTrue(1.5.toNearest(10.0).within(1e-3, of: 0.0))
        XCTAssertTrue(1.4.toNearest(10.0).within(1e-3, of: 0.0))

        XCTAssertTrue(5.0.toNearest(10.0).within(1e-3, of: 10.0))
        XCTAssertTrue(15.0.toNearest(10.0).within(1e-3, of: 20.0))
        XCTAssertTrue(14.0.toNearest(10.0).within(1e-3, of: 10.0))
    }
    func testRoundTo0_5() {
        XCTAssertTrue(0.25.toNearest(0.5).within(1e-3, of: 0.5))
        XCTAssertTrue(0.75.toNearest(0.5).within(1e-3, of: 1.0))
        XCTAssertTrue(0.74.toNearest(0.5).within(1e-3, of: 0.5))
    }
}
