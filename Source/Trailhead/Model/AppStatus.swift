//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

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

/// Protocol to designate that a class needs AppStatus injected into it.
protocol AppStatusInjectable: Injectable {
    /// Property to be injected into the class adopting this protocol.
    var appStatus: AppStatus! { get set }
}

/// Ephemeral or non-application data
class AppStatus {
    /// State of the app
    let appState = BehaviorRelay<AppState>(value: .initializing)

    /// Placeholder data item to simulate a situation where
    ///   the app has a BLE connection.
    let bleConnected = BehaviorRelay<Bool>(value: false)
}
