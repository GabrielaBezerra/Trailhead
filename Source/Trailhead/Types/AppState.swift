//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

/// Representation of the state of the app
enum AppState: CustomStringConvertible {
    /// Connected to device
    case connected
    /// General Error
    case error
    /// Application is initializing (not ready)
    case initializing
    /// Application is ready (done initialized)
    case ready
    /// Application is scanning for devices
    case scanning
    
    /// Clean representation of the state
    var description: String {
        switch self {
        case .connected: return "Connected"
        case .error: return "Error"
        case .initializing: return "Initializing"
        case .ready: return "Ready"
        case .scanning: return "Scanning"
        }
    }
}
