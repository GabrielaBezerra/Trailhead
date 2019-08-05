//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

class HomeViewModel: AppStatusInjectable, AppDataInjectable {
    var appStatus: AppStatus! = nil
    var appData: AppData! = nil

    let disposeBag = DisposeBag()

    // Use BehaviorRelay to have an initial value, and to
    //   denote that the stream is not inherently time-limited (Will not error or complete).
    let screenTitle = BehaviorRelay<String>(value: NSLocalizedString("Home", comment: "Home Screen Title"))
    let appStateText = BehaviorRelay<String>(value: "App State:")

    // MARK: - Lifecycle
    func injectionDone() {
        checkForNil()
        setupRx()
        
        exampleTimers()
    }

    // MARK: - ReactiveX
    private func setupRx() {
        // When appState changes, update appStateText.
        appStatus.appState
            .asDriver()
            .map({ "App State: \($0.description)" })
            .drive(appStateText)
            .disposed(by: disposeBag)
    }

    // MARK: - Utility Functions
    func checkForNil() {
        assert(appStatus != nil)
        assert(appData != nil)
    }
    
    private func exampleTimers() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.appStatus.appState.accept(.ready)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
            self?.screenTitle.accept("After 5 seconds")
        }
    }
    

    // This is to show preferred method to update model from view controller.
    // Namely by ViewController passing request to ViewModel and
    // ViewModel handling it if it's local to this scene or passing on to
    // Model if app-wide.
    func eulaAccepted(_ value: Bool) {
        appData.eulaAccepted.accept(value)
    }
}

