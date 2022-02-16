//
//  Topic.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import Foundation

enum Topic: Item {

    case rating
    case share
    case appt
    case abra
    case sidnFonds
    
    /** Title */
    var title: String {
        switch self {
        case .rating:
            return "Rate the app"
        case .share:
            return "Share the app"
        case .appt:
            return "Appt Foundation"
        case .abra:
            return "Abra"
        case .sidnFonds:
            return "SIDN fund"
        }
    }

    /** Website */
    var website: String {
        switch self {
        case .rating:
            return "https://apps.apple.com/us/app/screenreader/id1610318073" // TODO: Double check id
        case .share:
            return "Download the free ScreenReader app at https://screenreader.app and learn how to use the screen reader!"
        case .appt:
            return "https://appt.org"
        case .abra:
            return "https://abra.nl"
        case .sidnFonds:
            return "https://sidnfonds.nl"
        }
    }
}
