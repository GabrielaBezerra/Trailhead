//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import XCTest
@testable import Trailhead

class FloatUtilitiesTests: XCTestCase {
    func testWithin() {
        XCTAssertTrue(Float(0.5).within(0.5, of: 1.0))
        XCTAssertFalse(Float(0.5).within(0.4999, of: 1.0))

        XCTAssertTrue(Float(1.5).within(0.5, of: 1.0))
        XCTAssertFalse(Float(1.5).within(0.4999, of: 1.0))

        XCTAssertFalse(Float(0.5).within(0.0, of: 0.5))
    }

    func testRoundTo1() {
        XCTAssertTrue(Float(0.5).toNearest(1.0).within(1e-3, of: 1.0))
        XCTAssertTrue(Float(1.5).toNearest(1.0).within(1e-3, of: 2.0))
        XCTAssertTrue(Float(1.4).toNearest(1.0).within(1e-3, of: 1.0))
    }
    func testRoundTo10() {
        XCTAssertTrue(Float(0.5).toNearest(10.0).within(1e-3, of: 0.0))
        XCTAssertTrue(Float(1.5).toNearest(10.0).within(1e-3, of: 0.0))
        XCTAssertTrue(Float(1.4).toNearest(10.0).within(1e-3, of: 0.0))

        XCTAssertTrue(Float(5.0).toNearest(10.0).within(1e-3, of: 10.0))
        XCTAssertTrue(Float(15.0).toNearest(10.0).within(1e-3, of: 20.0))
        XCTAssertTrue(Float(14.0).toNearest(10.0).within(1e-3, of: 10.0))
    }
    func testRoundTo0_5() {
        XCTAssertTrue(Float(0.25).toNearest(0.5).within(1e-3, of: 0.5))
        XCTAssertTrue(Float(0.75).toNearest(0.5).within(1e-3, of: 1.0))
        XCTAssertTrue(Float(0.74).toNearest(0.5).within(1e-3, of: 0.5))
    }
}
