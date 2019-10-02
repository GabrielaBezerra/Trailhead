//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import Foundation

/// For injecting dependency manager itself.
///
/// NOTE: This should only get used by Coordinators. If another class is
///   conforming to this, most likely something is not designed properly.
protocol DependencyManagerInjectable {
    /// Property to be injected into the class adopting this protocol.
    var dependencyManager: DependencyManager! { get set }
}

/// Very basic dependency manager
///
/// Intention is to have this class updated to handle all the various *Injectable
/// conforming classes and inject the dependencies into them.
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
    /// App Status example class
    ///
    /// Reference type is currently preferred as the object will be instantiated
    /// in this class then passed into classes that need it.
    fileprivate var appStatus: AppStatus!
    /// App Data example class
    ///
    /// Reference type is currently preferred as the object will be instantiated
    /// in this class then passed into classes that need it.
    fileprivate var appData: AppData!

    /// Initialize the dependency manager (one per app)
    ///
    /// Parameters are intended to allow injection into the dependency manager
    /// for testing.
    ///
    /// - Parameters:
    ///   - appStatus: appStatus to use, otherwise AppStatus()
    ///   - appData: appData to use, otherwise AppData()
    init(appStatus: AppStatus? = nil,
         // This is only for testing. Consider moving it to test target.
         // But, have to expose fileprivate properties. Probably better
         // to be left here.
         appData: AppData? = nil) {
        // Use default constructors if not provided values.
        self.appStatus = appStatus ?? AppStatus()
        self.appData = appData ?? AppData()
    }

    /// Inject dependencies into the injectableClass
    ///
    /// - Parameter injectableClass: class conforming to *Injectable
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
