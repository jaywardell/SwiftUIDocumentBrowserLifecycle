//
//  SwiftUI+UIKit+RootViewController.swift
//  ExampleDocumentApp
//
//  Created by Joseph Wardell on 6/9/23.
//

#if canImport(UIKit)
import SwiftUI
import UIKit

extension UIWindowScene {
    func firstWindow<T: UIViewController>(containingRootViewController type: T.Type) -> UIWindow? where T: UIViewController {
        windows.first(where: { window in
            nil != window.rootViewController as? T
        })
    }
}

extension UIApplication {
    func first<T: UIViewController>(_ viewController: T.Type) -> T? where T: UIViewController {
        let window = connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first {
                nil != $0.firstWindow(containingRootViewController: T.self)
        }
        return window?.firstWindow(containingRootViewController: T.self)?.rootViewController as? T
    }
}
#endif
