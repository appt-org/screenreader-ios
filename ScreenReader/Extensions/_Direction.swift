//
//  Direction.swift
//  Appt
//
//  Created by Jan Jaap de Groot on 23/09/2020.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import UIKit

extension UISwipeGestureRecognizer.Direction {
    
    var name: String {
        switch self {
        case .up:
            return "direction_up".localized
        case .right:
            return "direction_right".localized
        case .down:
            return "direction_down".localized
        case .left:
            return "direction_left".localized
        default:
            return "direction_unknown".localized
        }
    }
}
