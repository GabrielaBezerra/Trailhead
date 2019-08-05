//
//  Copyright © 2019 Matt Whitlock. All rights reserved.
//

import Foundation

/// Possible API Errors
enum APIError: LocalizedError {
    case badURL
    case decodeError(Error)
    case requestError
    case urlSessionError(Error)
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
