//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

/// Navigation related functions for Coordinator to handle.
///
/// Seemingly redundant naming here is used as each function is handled
/// by a coordinator that may be handling similar action from multiple
/// viewcontrollers.
///
/// For example, NextTapped() makes sense if that action from multiple
/// screens is to be handled in one location.
///
protocol HomeNavigationDelegate: class {
}


/// Home View Controller for the app
class HomeViewController: UIViewController, Storyboarded, Coordinatable {
    // Coordinatable:
    let showsNavigationBar = false
    let popsOnDismiss = false
    
    // Storyboarded:
    static var storyboardName: String { return "Main" }
    
    weak var navigationDelegate: HomeNavigationDelegate?

    @IBOutlet weak var appStateLabel: UILabel!
    @IBOutlet weak var eulaAcceptedLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var declineButton: UIButton!
    
    var homeViewModel = HomeViewModel() // DependencyManager will handle DI to VM.
    let disposeBag = DisposeBag()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeUI()
        setupRx()
    }

    // MARK: - ReactiveX
    private func setupRx() {
        homeViewModel.screenTitle
            .asDriver()
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        // alternative to IBAction to handle button action
        acceptButton.rx.tap
            .asObservable()
            .bind(onNext: { [weak self] _ in
                self?.homeViewModel.eulaAccepted(true)
            })
            .disposed(by: disposeBag)
        
        homeViewModel.appStateText
            .asDriver()
            .drive(appStateLabel.rx.text)
            .disposed(by: disposeBag)
        
        // Technically can reach through viewModel to get the
        // underlying objects, but don't do this.
        homeViewModel.appData.eulaAccepted
            .asDriver()
            .map({ "EULA Accepted: \($0 ? "Yes" : "No")" })
            .drive(eulaAcceptedLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    // MARK: - IBActions
    // Alternative to .rx.tap to handle button action
    @IBAction func declineEULA(_ sender: Any) {
        // Alternative to rx drive for handling button action
        homeViewModel.eulaAccepted(false)
    }
    
    
    // MARK: - UI helper functions
    func initializeUI() {
    }

    // MARK: - Utility Functions
    func checkForNil() {
        assert(navigationDelegate != nil)
        assert(appStateLabel != nil)
    }

    // MARK: - Navigation
    // Use Coordinator for all navigation.
}

