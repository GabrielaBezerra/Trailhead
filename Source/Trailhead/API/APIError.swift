//
//  Copyright © 2019 Matt Whitlock. All rights reserved.
//

import Foundation

/// Possible API Errors
enum APIError: LocalizedError {
    /// Bad (malformed) URL
    case badURL
    /// Error decoding
    case decodeError(Error)
    /// Error during request
    case requestError
    /// Error creating or executing URLSession
    case urlSessionError(Error)
    /// Operation timed out
    case timeout

//    var errorDescription: String? {
//        switch self {
//        case .badURL:
//            return ""
//        case .decodeError(let error):
//            return ""
//        case .requestError:
//            return ""
//        case .urlSessionError(let error):
//            return ""
//        case .timeout:
//            return ""
//        }
//    }
}
