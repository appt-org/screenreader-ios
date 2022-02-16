//
//  _UIFont.swift
//  Screenreader
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

extension UIFont {
    
    static let openSansRegular = "OpenSans-Regular"
    static let openSansSemiBold = "OpenSans-SemiBold"
    static let openSansBold = "OpenSans-Bold"
    
    static func openSans(weight: UIFont.Weight, size: CGFloat, style: TextStyle = .body, scaled: Bool = true, maxSize: CGFloat = 100) -> UIFont {
        if UIAccessibility.isBoldTextEnabled {
            return font(name: openSansRegular, size: size, style: style, scaled: scaled, maxSize: maxSize)
        }
        
        switch weight {
            case .regular:
                return font(name: openSansRegular, size: size, style: style, scaled: scaled, maxSize: maxSize)
            case .semibold:
                return font(name: openSansSemiBold, size: size, style: style, scaled: scaled, maxSize: maxSize)
            case .bold:
                return font(name: openSansBold, size: size, style: style, scaled: scaled, maxSize: maxSize)
            default:
                fatalError("Font weight \(weight) not supported")
        }
    }

    private static func font(name: String, size: CGFloat, style: TextStyle, scaled: Bool, maxSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            fatalError("Font \(name) does not exist")
        }
        guard scaled else {
            return font
        }
        let scaledFont = UIFontMetrics(forTextStyle: style).scaledFont(for: font)
        guard scaledFont.pointSize < maxSize else {
            return scaledFont.withSize(maxSize)
        }
        return scaledFont
    }
}
