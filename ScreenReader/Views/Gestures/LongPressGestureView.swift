//
//  LongPressGestureView.swift
//  Appt
//
//  Created by Jan Jaap de Groot on 18/08/2020.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import UIKit
import AVFoundation

class LongPressGestureView: GestureView {
    
    var taps = 1
    var fingers = 1

    convenience init(gesture: Gesture, taps: Int, fingers: Int, duration: Double = 2.0) {
        self.init(gesture: gesture)
        self.taps = taps
        self.fingers = fingers
        
        for tapsRequired in 1...4 {
            for fingersRequired in 1...4 {
                let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
                tapRecognizer.cancelsTouchesInView = true
                tapRecognizer.numberOfTapsRequired = tapsRequired
                tapRecognizer.numberOfTouchesRequired = fingersRequired
                tapRecognizer.delegate = self
                addGestureRecognizer(tapRecognizer)
                
                let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(onLongPress(_:)))
                longPressRecognizer.cancelsTouchesInView = true
                longPressRecognizer.numberOfTapsRequired = tapsRequired - 1 // Subtract one because it starts at zero.
                longPressRecognizer.numberOfTouchesRequired = fingersRequired
                longPressRecognizer.minimumPressDuration = duration
                longPressRecognizer.delegate = self
                addGestureRecognizer(longPressRecognizer)
            }
        }
    }
    
    @objc func onTap(_ sender: UITapGestureRecognizer) {
        onEvent(recognizer: sender, amountOfTaps: sender.numberOfTapsRequired, amountOfFingers: sender.numberOfTouchesRequired, longPress: false)
    }
    
    @objc func onLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            // Add one to reflect the total amount of taps
            onEvent(recognizer: sender, amountOfTaps: sender.numberOfTapsRequired + 1, amountOfFingers: sender.numberOfTouchesRequired, longPress: true)
        }
    }
    
    func onEvent(recognizer: UIGestureRecognizer, amountOfTaps: Int, amountOfFingers: Int, longPress: Bool) {
        showTouches(recognizer: recognizer, tapCount: amountOfTaps, longPress: longPress)
        
        guard fingers == amountOfFingers else {
            // Incorrect amount of fingers
            incorrect("feedback_fingers".localized(fingers, amountOfFingers))
            return
        }
        
        guard taps == amountOfTaps else {
            // Incorrect amount of taps
            incorrect("feedback_taps_amount".localized(taps, amountOfTaps))
            return
        }
        
        guard longPress else {
            // Incorrect duration
            incorrect("feedback_longpress".localized(amountOfFingers))
            return
        }
        
        correct()
    }
         
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        incorrect("feedback_tap".localized)
    }
}

// MARK: - UIGestureRecognizerDelegate

extension LongPressGestureView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if let _ = gestureRecognizer as? UITapGestureRecognizer, let _ = otherGestureRecognizer as? UILongPressGestureRecognizer {
            // Tap must fail before long press
            return true
        }
        
        if let tapRecognizer = gestureRecognizer as? UITapGestureRecognizer, let otherTapRecognizer = otherGestureRecognizer as? UITapGestureRecognizer {
            // Fail if other tap recognizer requires more taps
            if tapRecognizer.numberOfTapsRequired < otherTapRecognizer.numberOfTapsRequired {
                return true
            }
            
            // Fail if other tap recognizer requires more fingers
            if tapRecognizer.numberOfTouchesRequired < otherTapRecognizer.numberOfTouchesRequired {
                return true
            }
        }
        
        if let longPressRecognizer = gestureRecognizer as? UILongPressGestureRecognizer, let otherLongPressRecognizer = otherGestureRecognizer as? UILongPressGestureRecognizer {
            // Fail if other long press recognizer requires more taps
            if longPressRecognizer.numberOfTapsRequired < otherLongPressRecognizer.numberOfTapsRequired {
                return true
            }
            
            // Fail if other long press recognizer requires more fingers
            if longPressRecognizer.numberOfTouchesRequired < otherLongPressRecognizer.numberOfTouchesRequired {
                return true
            }
        }
                
        return false
    }
}
