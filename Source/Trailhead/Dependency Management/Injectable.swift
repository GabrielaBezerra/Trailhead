//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

/// Base protocol for creating *Injectable protocols to designate classes
/// that should be injected into.
///
/// This base protocol provides a pseudo lifecycle as well as requirement
/// for nil functionality.
protocol Injectable {
    /// Check for any dependencies that should be initialized.
    ///
    /// Typically used to ensure delegate and IBOutlets are set.
    func checkForNil()

    /// "Lifecycle" event on an injectable object called by the DependencyManager when injection is done.
    func injectionDone() // Have to leave this here or cannot override default implementation.
}

extension Injectable {
    func injectionDone() {
        checkForNil()
    }
}
