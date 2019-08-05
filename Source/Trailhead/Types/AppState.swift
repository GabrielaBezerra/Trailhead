//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

enum AppState: CustomStringConvertible {
    case connected
    case error
    case initializing
    case ready
    case scanning
    
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
