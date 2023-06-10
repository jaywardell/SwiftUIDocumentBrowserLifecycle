//
//  DocumentBrowserEventListener.swift
//  TemplatableDocumentApp
//
//  Created by Joseph Wardell on 6/9/23.
//

#if canImport(UIKit)
import Foundation
import Combine
import UIKit

/// A type that listens for times when a UIWindowScene containing a UIDocumentBrowserViewController is connected
/// and calls a configure closure on the UIDocumentBrowserViewController
public struct DocumentBrowserEventListener {
    private var subscriptions = Set<AnyCancellable>()

    public struct Event {
        let notificationName: Notification.Name

        static var wasCreated: Self = .init(notificationName: UIScene.willConnectNotification)
        static var becameActive: Self = .init(notificationName: UIScene.didActivateNotification)
        static var becameInactive: Self = .init(notificationName: UIScene.didEnterBackgroundNotification)
    }

    public init(_ event: Event,  _ configure: @escaping (UIDocumentBrowserViewController) -> Void) {

        NotificationCenter.default.publisher(for: event.notificationName)
            .map { $0.object as? UIWindowScene }
            .compactMap { $0?.firstWindow(containingRootViewController: UIDocumentBrowserViewController.self) }
            .compactMap { $0.rootViewController as? UIDocumentBrowserViewController }
            .sink(receiveValue: configure)
            .store(in: &subscriptions)
    }
}

#endif
