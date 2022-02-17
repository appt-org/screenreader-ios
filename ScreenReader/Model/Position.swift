//
//  Position.swift
//  Appt
//
//  Created by Jan Jaap de Groot on 24/07/2020.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import UIKit

enum Position {

    case top
    case bottom

    /** Name */
    var name: String {
        if self == .top {
            return "position_top".localized
        } else {
            return "position_bottom".localized
        }
    }
    
    /** Determine position based on a recognizer and it's view */
    public static func from(recognizer: UIGestureRecognizer, view: UIView) -> Position {
        let location = recognizer.location(in: view)
        
        if location.y < (view.frame.height / 2) {
            return .top
        } else {
            return .bottom
        }
    }
}
