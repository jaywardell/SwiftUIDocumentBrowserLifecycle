//
//  UIBarButtonItem+SFSymbols.swift
//  TemplatableDocumentApp
//
//  Created by Joseph Wardell on 6/9/23.
//

#if canImport(UIKit)
import UIKit

public extension UIBarButtonItem {
    convenience init(systemImageName: String,
                     scale: UIImage.SymbolScale = .large,
                     target: NSObject? = nil,
                     action: ObjectiveC.Selector? = nil) {
        let config = UIImage.SymbolConfiguration(scale: scale)
        let image = UIImage(systemName: systemImageName, withConfiguration: config)
        self.init(image: image, style: .plain, target: target, action: action)
    }
}
#endif
