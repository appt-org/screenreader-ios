//
//  _String.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 17/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import Foundation

extension String {
    var htmlDecoded: String {
        do {
            return try NSAttributedString(data: Data(utf8), options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil).string
        } catch {
            print("Error decoding HTML: \(error)")
        }
        return self
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "Localized")
    }
    
    func localized(_ arguments: CVarArg...) -> String {
        return String(format: self.localized, locale: .current, arguments: arguments)
    }
}
