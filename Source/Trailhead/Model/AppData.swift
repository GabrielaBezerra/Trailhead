//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

/*
 AppData & AppStatus

 AppData is a placeholder class that is meant to represent the presence
 of many smaller model objects that will be injected as applicable by
 the DependencyManager.

 AppStatus is intended for ephemeral or non application data including queued
 requests, view state information, connected/disconnected status.

 AppData is generally persisted in its entirety although exceptions may occur.
 AppStatus is a mix between persisted and ephemeral data.
 */


protocol AppDataInjectable: Injectable {
    var appData: AppData! { get set }
}

class AppData {
    /// Placeholder data item to simulate a situation where
    ///   the app has a one-time initialization flow.
    let eulaAccepted = BehaviorRelay<Bool>(value: false)
}
