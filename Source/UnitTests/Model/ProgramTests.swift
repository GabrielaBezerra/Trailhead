//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import XCTest
@testable import Trailhead
import RealmSwift

class FavoriteTests: XCTestCase {
    func testCreateTestRealmWithProgram() {
        guard let (realm, program) = try? TestHelper.createTestRealmWithOneProgram() else {
            XCTFail("Realm creation failed")
            return
        }

        XCTAssertEqual(realm.objects(Program.self).count, 1)
        XCTAssertEqual(program.name, "Program 1")
        XCTAssertEqual(program.number, 1)
    }

    func testFavoriteUpdate() {
        guard let (_, program) = try? TestHelper.createTestRealmWithOneProgram() else {
            XCTFail("Realm creation failed")
            return
        }

        XCTAssertNotEqual(program.name, "NewName")
        XCTAssertNotEqual(program.number, 123)
        XCTAssertNotEqual(program.level, 1.0)
        XCTAssertNotEqual(program.duration, 2.0)
        XCTAssertNotEqual(program.rate, 234)
        XCTAssertNotEqual(program.enabled, true)
        do {
            try program.update(
                name: "NewName",
                number: 123,
                level: 1.0,
                duration: 2.0,
                rate: 234,
                enabled: true)
        } catch {
            XCTFail("Update failed: \(error).")
        }
        XCTAssertEqual(program.name, "NewName")
        XCTAssertEqual(program.number, 123)
        XCTAssertEqual(program.level, 1.0)
        XCTAssertEqual(program.duration, 2.0)
        XCTAssertEqual(program.rate, 234)
        XCTAssertEqual(program.enabled, true)
    }
}
