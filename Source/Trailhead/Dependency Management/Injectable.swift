//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

protocol Injectable {
    func checkForNil()
    func injectionDone() // Have to leave this here or cannot override default implementation.
}

extension Injectable {
    func injectionDone() {
        checkForNil()
    }
}
