//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    let configuration: Realm.Configuration

    // Only way to get a RealmManager instance should be through app static variable or copyForTesting()
    fileprivate init(withConfiguration config: Realm.Configuration) {
        configuration = config

        // Set default realm configuration so that future calls of try? Realm() work without modification.
        Realm.Configuration.defaultConfiguration = config
    }
}

// MARK: - Extension to RealmManager for test use only.
extension RealmManager {
    func copyForTesting(setAsDefault: Bool = false) -> RealmManager {
        // Modify configuration to in-memory for testing
        var inMemoryConfig = configuration
        inMemoryConfig.inMemoryIdentifier = UUID().uuidString
        return RealmManager(withConfiguration: inMemoryConfig)
    }
}
