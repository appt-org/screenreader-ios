//
//  Action2.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 25/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

protocol Action2: Learning {
    
    var identifier: String { get }
    var items: [Any] { get }
    
    func onFocusChanged(_ elements: [UIAccessibilityElement]) -> Bool
    func onFocusChanged(_ views: [UIView]) -> Bool
    func onPasteboardChanged(_ content: String?) -> Bool
    
}

extension Action2 {
    
    var completed: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: identifier)
        }
        get {
            return UserDefaults.standard.bool(forKey: identifier)
        }
    }
    
    var title: String {
        get {
            return NSLocalizedString("action_"+identifier+"_title", comment: "")
        }
    }
    
    func onFocusChanged(_ elements: [UIAccessibilityElement]) -> Bool {
        return false
    }
    
    func onFocusChanged(_ views: [UIView]) -> Bool {
        return false
    }
    
    func onPasteboardChanged(_ content: String?) -> Bool {
        return false
    }
}
