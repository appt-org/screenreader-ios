//
//  Events.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 13/05/2022.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import Foundation
import FirebaseAnalytics

class Events {
    
    // MARK: - Property
    
    enum Property: String {
        case screenreader
    }
    
    public static func property(_ property: Property, value: String) {
        Analytics.setUserProperty(value, forName: property.rawValue)
    }
    
    public static func property(_ property: Property, value: Bool) {
        Events.property(property, value: value ? "1" : "0")
    }
    
    // MARK: - Event
    
    enum Category: String {
        case action_completed
        case gesture_completed
    }
    
    public static func log(_ category: Category, identifier: String, value: Int? = nil) {
        print("Log event, category: \(category), identifier: \(identifier), value: \(value ?? -1)")
        
        var parameters: [String: Any] = [
            AnalyticsParameterItemID: identifier
        ]
        
        if let value = value {
            parameters[AnalyticsParameterValue] = value
        }
        
        Analytics.logEvent(category.rawValue, parameters: parameters)
    }
}
