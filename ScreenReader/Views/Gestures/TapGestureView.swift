//
//  TapGestureView.swift
//  Appt
//
//  Created by Jan Jaap de Groot on 28/06/2020.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import UIKit

class TapGestureView: GestureView {
    
    private var taps = 1
    private var fingers = 1
    private var position: Position?
    
    convenience init(gesture: Gesture, taps: Int, fingers: Int, position: Position? = nil) {
        self.init(gesture: gesture)
        self.taps = taps
        self.fingers = fingers
        self.position = position
        
        // Recognize multiple amount of fingers and multiple amount of taps for improved feedback
        for tapsRequired in 1...4 {
            for fingersRequired in 1...4 {
                let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
                recognizer.cancelsTouchesInView = true
                recognizer.numberOfTapsRequired = tapsRequired
                recognizer.numberOfTouchesRequired = fingersRequired
                recognizer.delegate = self
                addGestureRecognizer(recognizer)
            }
        }
        
        if fingers == 3 && taps >= 2 {
            UIAccessibility.registerGestureConflictWithZoom()
        }
    }

    @objc func onTap(_ sender: UITapGestureRecognizer) {
        showTouches(recognizer: sender, tapCount: sender.numberOfTapsRequired)
        
        guard fingers == sender.numberOfTouchesRequired else {
            // Incorrect amount of fingers
            incorrect("feedback_taps_fingers".localized(fingers, sender.numberOfTouchesRequired))
            return
        }
        
        guard taps == sender.numberOfTapsRequired else {
            // Incorrect amount of taps
            incorrect("feedback_taps_amount".localized(taps, sender.numberOfTapsRequired))
            return
        }
        
        guard let position = position else {
            // No position required
            correct()
            return
        }

        let location = Position.from(recognizer: sender, view: self)
        guard position == location else {
            // Incorrect position
            incorrect("feedback_position".localized(position.name, location.name))
            return
        }

        // Correct position
        correct()
    }
        
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        incorrect("feedback_tap".localized)
    }
}

// MARK: - UIGestureRecognizerDelegate

extension TapGestureView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let tapRecognizer = gestureRecognizer as? UITapGestureRecognizer, let otherTapRecognizer = otherGestureRecognizer as? UITapGestureRecognizer else {
            return false
        }
        
        // Fail if other tap recognizer requires more taps
        if tapRecognizer.numberOfTapsRequired < otherTapRecognizer.numberOfTapsRequired {
            return true
        }
        
        // Fail if other tap recognizer requires more fingers
        if tapRecognizer.numberOfTouchesRequired < otherTapRecognizer.numberOfTouchesRequired {
            return true
        }
        
        return false
    }
}
