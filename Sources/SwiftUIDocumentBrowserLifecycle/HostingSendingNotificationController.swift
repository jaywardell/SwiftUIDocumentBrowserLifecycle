//
//  HostingSendingNotificationController.swift
//  TemplatableDocumentApp
//
//  Created by Joseph Wardell on 6/9/23.
//

#if canImport(UIKit)
import SwiftUI

/// A UIHostingController subclass that has a single action that sends a Notification with a given canned NSObject
final class HostingSendingNotificationController<Content: View>: UIHostingController<Content> {

    let notificationName: Notification.Name
    weak var sentObject: NSObject!

    init(rootView: Content, notificationName: Notification.Name, sentObject: NSObject) {
        self.notificationName = notificationName
        self.sentObject = sentObject

        super.init(rootView: rootView)
    }

    // should never be called
    @MainActor required dynamic init?(coder aDecoder: NSCoder) { fatalError() }

    @objc
    func sendNotification(sender: Any) {
        NotificationCenter.default.post(name: notificationName, object: sentObject)
    }
}
#endif
