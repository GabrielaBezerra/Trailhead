//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

/// Representation of the Model objects for the HomeViewController
class HomeViewModel: AppStatusInjectable, AppDataInjectable {
    var appStatus: AppStatus! = nil
    var appData: AppData! = nil

    /// Rx Disposebag to do "garbage collection"
    let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    func injectionDone() {
        checkForNil()
        setupRx()
        
        exampleTimers()
    }

    // MARK: - ReactiveX
    // MARK: BehaviorRelays
    /// Use BehaviorRelay to have an initial value, and to
    ///   denote that the stream is not inherently time-limited (Will not error or complete).
    
    /// Title for the screen
    let screenTitle = BehaviorRelay<String>(value: NSLocalizedString("Home", comment: "Home Screen Title"))
    /// Text description of the Application State
    let appStateText = BehaviorRelay<String>(value: "App State:")
    
    // MARK: Rx Utility
    /// Configure any Rx functionality
    private func setupRx() {
        // When appState changes, update appStateText.
        appStatus.appState
            .asDriver()
            .map({ "App State: \($0.description)" })
            .drive(appStateText)
            .disposed(by: disposeBag)
    }

    // MARK: - Utility Functions
    /// Check that all Injectable properties have been set
    func checkForNil() {
        assert(appStatus != nil)
        assert(appData != nil)
    }
    
    /// Simple example of 3 second and 5 second timers
    ///
    /// Used to demonstrate simple Rx functionality
    private func exampleTimers() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.appStatus.appState.accept(.ready)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
            self?.screenTitle.accept("After 5 seconds")
        }
    }
    

    /// Update EULA accepted status
    ///
    /// - Parameter value: Has the EULA been accepted
    ///
    /// This is to show preferred method to update model from view controller.
    /// Namely by ViewController passing request to ViewModel and
    /// ViewModel handling it if it's local to this scene or passing on to
    /// Model if app-wide.
    func eulaAccepted(_ value: Bool) {
        appData.eulaAccepted.accept(value)
    }
}

