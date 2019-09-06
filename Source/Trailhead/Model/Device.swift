//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import Foundation
import RealmSwift

/// Representation of a device connected to via BLE
class Device: Object {
    // Specify Realm primary key:
    override static func primaryKey() -> String? {
        return "id"
    }
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var charging = Bool()

    @objc dynamic var selectedProgram: Program?

    // Manufacturing info
    @objc dynamic var udi = String()
    @objc dynamic var model = String()
    @objc dynamic var serial = String()
    @objc dynamic var yearOfManufacture = Int() // 4 digit year
    @objc dynamic var firmwareVersion = String()


    convenience init(programCount: Int) {
        self.init()
        for i in 1...programCount {
            programs.append(Program(number: i, name: "Program \(i)"))
        }
    }

    let programs = List<Program>()
    // TODO: Add functionality to limit to a set number of programs,
    //   and to require an exact number of programs.
}

extension Device {
    /// Update device realm object with any value passed in
    ///
    /// - Parameters:
    ///   - name: name
    /// - Throws: RealmError if write failed or error getting Realm.
    func update(
        name: String? = nil,
        charging: Bool? = nil,
        udi: String? = nil,
        model: String? = nil,
        serial: String? = nil,
        yearOfManufacture: Int? = nil,
        firmwareVersion: String? = nil
        ) throws {
        try write("Update Program") {
            if let name = name {
                self.name = name
            }
            if let charging = charging {
                self.charging = charging
            }
            if let udi = udi {
                self.udi = udi
            }
            if let model = model {
                self.model = model
            }
            if let serial = serial {
                self.serial = serial
            }
            if let yearOfManufacture = yearOfManufacture {
                self.yearOfManufacture = yearOfManufacture
            }
            if let firmwareVersion = firmwareVersion {
                self.firmwareVersion = firmwareVersion
            }
        }
    }
}
