//
//  NotificationRespondingView.swift
//  TemplatableDocumentApp
//
//  Created by Joseph Wardell on 6/9/23.
//

import SwiftUI

/// A View that has no appearance, and listens for a given notification.
/// When the notification is received, it calls a callback,
/// passing in the notification received
struct NotificationRespondingView: View {

    let notificationName: Notification.Name
    let callback: (Notification) -> Void

    var body: some View {
        Color.clear
            .onReceive(NotificationCenter.default.publisher(for: notificationName)) { notification in
                callback(notification)
            }
    }
}
