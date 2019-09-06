//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import Foundation
import RealmSwift

/// Representation of a program (group of settings that can be selected) on a device
class Program: Object {
    // TODO: Use Sourcery to generate convenience init and update functions
    @objc dynamic var name = ""
    @objc dynamic var number = Int()
    @objc dynamic var level = Double()
    @objc dynamic var duration = Double()
    @objc dynamic var rate = Int()
    @objc dynamic var enabled = Bool()

    let device = LinkingObjects(fromType: Device.self, property: "programs")
}

extension Program {
    convenience init(number: Int, name: String) {
        self.init()
        self.number = number
        self.name = name
    }

    /// Update program realm object with any value passed in
    ///
    /// - Parameters:
    ///   - name: name
    ///   - number: number
    /// - Throws: RealmError if write failed or error getting Realm.
    func update(
        name: String? = nil,
        number: Int? = nil,
        level: Double? = nil,
        duration: Double? = nil,
        rate: Int? = nil,
        enabled: Bool? = nil
        ) throws {
        try write("Update Program") {
            if let name = name {
                self.name = name
            }
            if let number = number {
                self.number = number
            }
            if let level = level {
                self.level = level
            }
            if let duration = duration {
                self.duration = duration
            }
            if let rate = rate {
                self.rate = rate
            }
            if let enabled = enabled {
                self.enabled = enabled
            }
        }
    }
}
