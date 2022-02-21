//
//  Topic.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import Foundation

enum Topic: String, Item {

    case rating
    case share
    case appt
    case abra
    case sidnFonds = "sidn_fonds"
    
    /** Title */
    var title: String {
        return NSLocalizedString("topic_"+rawValue+"_title", comment: "")
    }

    /** Website */
    var website: String {
        return NSLocalizedString("topic_"+rawValue+"_website", comment: "")
    }
}
