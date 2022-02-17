//
//  _CGFloat.swift
//  Appt
//
//  Created by Jan Jaap de Groot on 22/09/2020.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import UIKit

extension CGFloat {
    
    // Converts a float between zero and one to a number of degrees (0-360)
    var degrees: Int {
        return Int(360 * self)
    }
}
