//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import Foundation
import RealmSwift

/// Handling for Realm operations
class RealmManager {
    /// Realm configuration
    let configuration: Realm.Configuration

    /// Initialize RealmManager with the selected configuration
    ///
    /// - Parameters:
    ///   - config: Realm Configuration to use
    ///   - setAsDefault: Update Realm default to use configuration on all try? Realm() calls
    ///
    /// Only way to get a RealmManager instance should be through app static variable or copyForTesting()
    /// FIXME: Some work could be used here to clean up the point of call.
    fileprivate init(withConfiguration config: Realm.Configuration, setAsDefault: Bool) {
        configuration = config

        // Set default realm configuration so that future calls of try? Realm() work without modification.
        Realm.Configuration.defaultConfiguration = config
    }
}

// MARK: - Extension to RealmManager for test use only.
extension RealmManager {
    /// Make an in memory copy of the realm
    ///
    /// - Parameter setAsDefault: Update the Realm default configuration to the in memory copy
    /// - Returns: Realm manager configured for in memory (for testing)
    func copyForTesting(setAsDefault: Bool = false) -> RealmManager {
        // Modify configuration to in-memory for testing
        var inMemoryConfig = configuration
        inMemoryConfig.inMemoryIdentifier = UUID().uuidString
        return RealmManager(withConfiguration: inMemoryConfig, setAsDefault: setAsDefault)
    }
}
