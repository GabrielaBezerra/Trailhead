//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import XCTest
@testable import Trailhead
import RealmSwift

class DeviceTests: XCTestCase {
    func testCreateTestRealmDeviceWithDeviceAndTwoPrograms() {
        guard let (realm, device) = try? TestHelper.createTestRealmWithDeviceAndTwoPrograms() else {
            XCTFail("Realm creation failed")
            return
        }

        XCTAssert(device.programs.count == 2)
        XCTAssert(device.programs.first!.name == "Program 1")

        XCTAssertEqual(realm.objects(Device.self).count, 1)
        XCTAssertEqual(realm.objects(Program.self).count, 2)
    }

    func testDeviceUpdate() {
        guard let (_, device) = try? TestHelper.createTestRealmWithDeviceAndTwoPrograms() else {
            XCTFail("Realm creation failed")
            return
        }

        XCTAssertNotEqual(device.name, "NewName")
        XCTAssertNotEqual(device.charging, true)
        XCTAssertNotEqual(device.udi, "1234")
        XCTAssertNotEqual(device.model, "2345")
        XCTAssertNotEqual(device.serial, "3456")
        XCTAssertNotEqual(device.yearOfManufacture, 2010)
        XCTAssertNotEqual(device.firmwareVersion, "4567")
        do {
            try device.update(
                name: "NewName",
                charging: true,
                udi: "1234",
                model: "2345",
                serial: "3456",
                yearOfManufacture: 2010,
                firmwareVersion: "4567"
            )
        } catch {
            XCTFail("Update failed: \(error).")
        }
        XCTAssertEqual(device.name, "NewName")
        XCTAssertEqual(device.name, "NewName")
        XCTAssertEqual(device.charging, true)
        XCTAssertEqual(device.udi, "1234")
        XCTAssertEqual(device.model, "2345")
        XCTAssertEqual(device.serial, "3456")
        XCTAssertEqual(device.yearOfManufacture, 2010)
        XCTAssertEqual(device.firmwareVersion, "4567")
    }
}
