//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import Foundation

/// For injecting dependency manager itself.
///
/// NOTE: This should only get used by Coordinators. If another class is
///   conforming to this, most likely something is not designed properly.
protocol DependencyManagerInjectable {
    var dependencyManager: DependencyManager! { get set }
}

final class DependencyManager {
    // Dependency manager is responsible for initializing and holding onto
    // long-lived data (full app lifecycle).
    //
    // For short lifecycle, use weak var properties, inject into the
    // relevant classes, then when those classes go away, so does
    // the instance in memory.
    //
    // View Models should be instantiated by their view controller in most
    // cases. Then dependency manager will be called on the viewmodel to
    // inject dependencies into it.
    fileprivate var appStatus: AppStatus!
    fileprivate var appData: AppData!


    // This is only for testing. Consider moving it to test target.
    // But, have to expose fileprivate properties. Probably better
    // to be left here.
    init(appStatus: AppStatus? = nil,
         appData: AppData? = nil) {
        // Use default constructors if not provided values.
        self.appStatus = appStatus ?? AppStatus()
        self.appData = appData ?? AppData()
    }

    func inject(_ injectableClass: AnyObject) {
        defer {
            // This has to be the last item in the function to create the 'lifecycle',
            // so using defer.
            if let injectableClass = injectableClass as? Injectable {
                injectableClass.injectionDone()
            }
        }
        // FIXME: Can this be Any to support structs? - No.

        // For each injectable type, check if class conforms to it and
        //   inject the corresponding data.
        if var appStatusInjectable = injectableClass as? AppStatusInjectable {
            appStatusInjectable.appStatus = appStatus
        }
        if var appDataInjectable = injectableClass as? AppDataInjectable {
            appDataInjectable.appData = appData
        }
        if var dependencyManagerInjectable = injectableClass as? DependencyManagerInjectable {
            dependencyManagerInjectable.dependencyManager = self
        }
    }
}

