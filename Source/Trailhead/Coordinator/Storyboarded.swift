//
//  Copyright © 2019 Matt Whitlock All rights reserved.
//

import UIKit

/// Protocol for UIViewControllers to instantiate themselves from a storyboard.
///
/// Inspired from Paul Hudson's Storyboarded:
/// https://www.hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps
///
/// Requires that the name in the storyboard match the name of the class.
protocol Storyboarded {
    /// Name of the storyboard as defined in the storyboard
    static var storyboardName: String { get }

    /// UIViewController instantiate itself from storyboard, assuming storyboardName has been set properly
    ///
    /// - Returns: instantiated UIViewController
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        // Get name of ViewController class (i.e. MyApp.MyViewController)
        let fullName = NSStringFromClass(self)

        // Get everything after the App Bundle name (i.e. MyViewController)
        let className = fullName.split(separator: ".")[1]

        // Get the storyboard
        let storyboard = UIStoryboard(name: self.storyboardName, bundle: Bundle.main)

        // Ok to crash here. If instantiation of the ViewController fails,
        //   it's an unrecoverable development error that has to be fixed during development.
        // swiftlint:disable:next force_cast
        return storyboard.instantiateViewController(withIdentifier: String(className)) as! Self
    }
}
