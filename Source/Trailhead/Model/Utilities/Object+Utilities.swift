//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import Realm
import RealmSwift


/// Encapsulation of common Realm errors
///
/// - realmReference: Error getting Realm reference
/// - writeFailed: Realm write failed
enum RealmError: LocalizedError {
    /// Error getting realm reference
    case realmReference
    /// Write failed during operation
    case writeFailed(String, Error)

    /// String description of the enum case
    var errorDescription: String? {
        switch self {
        case .realmReference:
            return "Error getting realm reference."
        case .writeFailed(let name, let error):
            return "Realm write(\(name)) failed with error \(error.localizedDescription)."
        }
    }
}

/// Extension to base Realm Object class. Not to be confused with NSObject.
extension Object {
    /// Write change to realm with (try-catch) error checking.
    ///
    /// - Parameters:
    ///   - name: Description of the action trying to accomplish
    ///   - action: updates to realm objects
    /// - Returns: true if successful, false if not.
    func write(_ name: String, action: () -> Void) throws {
        // Write should be done from a managed object so it is part of a realm.
        //   If realm is nil, then it's not part of a realm.
        //   (hasn't been added or other issue)
        guard let realm = realm else {
            throw RealmError.realmReference
        }

        do {
            try realm.write {
                action()
            }
        } catch let error {
            throw RealmError.writeFailed(name, error)
        }
    }

}
