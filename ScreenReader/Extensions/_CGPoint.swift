//
//  _CGPoint.swift
//  Appt
//
//  Created by Jan Jaap de Groot on 30/09/2020.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import UIKit

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow((point.x - x), 2) + pow((point.y - y), 2))
    }
}
