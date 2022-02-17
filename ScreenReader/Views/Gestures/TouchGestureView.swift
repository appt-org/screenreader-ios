//
//  TouchGestureView.swift
//  Appt
//
//  Created by Jan Jaap de Groot on 31/07/2020.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import UIKit

class TouchGestureView: TapGestureView {

    private var taps: Int = 1
    private var fingers: Int = 1
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        correct()
    }
}
