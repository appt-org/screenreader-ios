//
//  DirectGestureView.swift
//  Appt
//
//  Created by Jan Jaap de Groot on 18/08/2020.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import UIKit
import AVKit

class DirectGestureView: LongPressGestureView {

    private var THRESHOLD = 25
    private var count = 0
    
    convenience init(gesture: Gesture) {
        self.init(gesture: gesture, taps: 2, fingers: 1)
    }
    
    override func onLongPress(_ sender: UILongPressGestureRecognizer) {
        if completed {
            return
        }
        
        showTouches(recognizer: sender, tapCount: sender.numberOfTapsRequired+1, longPress: true)
        
        if sender.state == .began {
            // Step 1: double tap long press
            AudioServicesPlaySystemSound(SystemSoundID(1255))
        } else if sender.state == .changed {
            // Step 2: make any gesture
            count += 1
            
            if count > THRESHOLD {
                correct()
            }
        } else if sender.state == .ended {
            count = 0
            incorrect("feedback_gesture".localized)
        }
    }
}
