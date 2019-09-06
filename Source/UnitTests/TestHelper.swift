//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

@testable import Trailhead

import Foundation
import RealmSwift
import XCTest

/// Utility functions to assist with unit testing
class TestHelper {
    private static func inMemoryConfiguration() -> Realm.Configuration {
        return Realm.Configuration(inMemoryIdentifier: UUID().uuidString)
    }
    /// Set global Realm configuration to be in memory.
    static func setRealmToInMemory() {
        Realm.Configuration.defaultConfiguration = inMemoryConfiguration()
    }

    static func emptyInMemoryRealm() -> Realm? {
        return try? Realm(configuration: inMemoryConfiguration())
    }

    static func createTestRealm() throws -> Realm {
        guard let realm = TestHelper.emptyInMemoryRealm() else {
            XCTFail("Realm Issue")
            throw RealmError.realmReference
        }
        return realm
    }

    static func createTestRealmWithDeviceAndTwoPrograms() throws -> (realm: Realm, device: Device) {
        let device = Device(programCount: 2)

        let realm = try createTestRealm()
        if !realm.isInWriteTransaction {
            realm.beginWrite()

            realm.add(device)
            try realm.commitWrite()
            return (realm, device)
        } else {
            throw RealmError.inWriteTransaction
        }
    }

    static func createTestRealmWithOneProgram() throws -> (realm: Realm, program: Program) {
        let program = Program(number: 1, name: "Program 1")

        // Add to realm
        let realm = try createTestRealm()
        if !realm.isInWriteTransaction {
            realm.beginWrite()

            realm.add(program)
            try realm.commitWrite()
            return (realm, program)
        } else {
            throw RealmError.inWriteTransaction
        }
    }

}
