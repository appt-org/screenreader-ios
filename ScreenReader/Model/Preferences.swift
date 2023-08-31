//
//  Preferences.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 31/08/2023.
//  Copyright © 2023 Stichting Appt & Abra B.V. All rights reserved.
//

import Foundation

class Preferences {
    
    private static let REVIEW = "review"
    
    static var isReviewPrompted: Bool {
        get {
            return UserDefaults.standard.bool(forKey: REVIEW)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: REVIEW)
        }
    }
}
