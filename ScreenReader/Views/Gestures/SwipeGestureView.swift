//
//  SwipeGestureView.swift
//  Appt
//
//  Created by Jan Jaap de Groot on 24/07/2020.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import UIKit

class SwipeGestureView: GestureView {
    
    private var direction: UISwipeGestureRecognizer.Direction!
    private var fingers = 1
    
    convenience init(gesture: Gesture, direction: UISwipeGestureRecognizer.Direction, fingers: Int) {
        self.init(gesture: gesture)
        self.direction = direction
        self.fingers = fingers
        
        // Recognize all directions and multiple amount of fingers for improved feedback
        let directions: [UISwipeGestureRecognizer.Direction] = [.up, .right, .down, .left]
        for direction in directions {
            for fingersRequired in 1...3 {
                let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
                recognizer.cancelsTouchesInView = false
                recognizer.direction = direction
                recognizer.numberOfTouchesRequired = fingersRequired
                recognizer.delegate = self
                addGestureRecognizer(recognizer)
            }
        }
    }

    @objc func onSwipe(_ sender: UISwipeGestureRecognizer) {
        guard fingers == sender.numberOfTouchesRequired else {
            // Incorrect amount of fingers
            incorrect("feedback_swipe_fingers".localized(fingers, sender.numberOfTouchesRequired))
            return
        }
        
        guard direction == sender.direction else {
            // Incorrect direction
            incorrect("feedback_direction".localized(direction.name, sender.direction.name))
            return
        }
        
        correct()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        incorrect("feedback_swipe".localized)
    }
}

// MARK: - UIGestureRecognizerDelegate

extension SwipeGestureView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let swipeRecognizer = gestureRecognizer as? UISwipeGestureRecognizer, let otherSwipeRecognizer = otherGestureRecognizer as? UISwipeGestureRecognizer else {
            return false
        }
    
        // Fail if other swipe recognizer requires more fingers
        if swipeRecognizer.numberOfTouchesRequired < otherSwipeRecognizer.numberOfTouchesRequired {
            return true
        }
        
        return false
    }
}
