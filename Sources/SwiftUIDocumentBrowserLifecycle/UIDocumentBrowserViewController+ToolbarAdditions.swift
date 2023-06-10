//
//  UIDocumentBrowserViewController+ToolbarAdditions.swift
//  TemplatableDocumentApp
//
//  Created by Joseph Wardell on 6/9/23.
//

#if canImport(UIKit)
import UIKit
import SwiftUI

public extension UIDocumentBrowserViewController {

    enum Position { case leading, trailing }

    func addLeadingToolbarItem(systemImageName: String,
                               scale: UIImage.SymbolScale = .large,
                               at position: Position = .leading,
                               callback: @escaping (UIDocumentBrowserViewController) -> ()) {

        addLeadingToolbarItem(UIBarButtonItem(systemImageName: systemImageName, scale: scale), at: position, callback: callback)
    }

    func addLeadingToolbarItem(_ barButtonItem: UIBarButtonItem,
                               at position: Position = .leading,
                               callback: @escaping (UIDocumentBrowserViewController) -> ()) {

        let notificationName = Notification.Name(UUID().uuidString)

        let provider = NotificationRespondingView(notificationName: notificationName) { notification in
                if let sender = notification.object as? UIBarButtonItem,
                   sender == barButtonItem {
                    callback(self)
                }
            }
        let vc = HostingSendingNotificationController(rootView: provider,
                                                      notificationName: notificationName,
                                                      sentObject: barButtonItem)
        barButtonItem.target = vc
        barButtonItem.action = #selector(HostingSendingNotificationController<NotificationRespondingView>.sendNotification)

        switch position {
        case .leading: additionalLeadingNavigationBarButtonItems += [barButtonItem]
        case .trailing: additionalTrailingNavigationBarButtonItems += [barButtonItem]
        }

        // add the view controller and its view to self and self's view
        // note that NotificationRespondingView presents as just a clear color
        // so there should be no visible change to the UI
        addChild(vc)
        view.addSubview(vc.view!)
        vc.didMove(toParent: self)
    }
}
#endif
