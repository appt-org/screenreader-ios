//
//  EscapeGestureView.swift
//  Appt
//
//  Created by Jan Jaap de Groot on 17/08/2020.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import UIKit

class EscapeGestureView: GestureView {
    
    private let THRESHOLD:CGFloat = 50
    
    private var fingers = 1
    private var directions = [Direction]()
    
    convenience init(gesture: Gesture, fingers: Int) {
        self.init(gesture: gesture)
        self.fingers = fingers
        
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        recognizer.cancelsTouchesInView = false
        recognizer.minimumNumberOfTouches = fingers
        recognizer.maximumNumberOfTouches = fingers
        addGestureRecognizer(recognizer)
    }
        
    @objc func onPan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        
        // Determine direction of pan gesture
        var direction = Direction.unknown
        if translation.x > THRESHOLD {
            if translation.y > THRESHOLD {
                direction = .bottomRight
            } else if translation.y < -THRESHOLD {
                direction = .topRight
            } else {
                direction = .right
            }
        } else if translation.x < -THRESHOLD {
            if translation.y > THRESHOLD {
                direction = .bottomLeft
            } else if translation.y < -THRESHOLD {
                direction = .topLeft
            } else {
                direction = .left
            }
        } else {
            if translation.y > THRESHOLD {
                direction = .bottom
            } else if translation.y < -THRESHOLD {
                direction = .top
            }
        }
        
        // Determine what to do based on recognizer state
        if sender.state == .began {
            // Gesture started, clear data.
            directions.removeAll()
        } else if sender.state == .changed && direction != .unknown {
            if directions.isEmpty {
                // First direction
                directions.append(direction)
            } else if let lastDirection = directions.last, direction != lastDirection {
                // Direction has changed
                directions.append(direction)
            }
        } else if sender.state == .ended {
            // Gesture finished, check directions.
            onPanDirections(directions)
        }
    }
    
    private func onPanDirections(_ directions: [Direction]) {
        if directions == [.right, .bottomRight, .bottom, .bottomRight] {
            correct()
        } else {
            incorrect("feedback_zigzag".localized)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if let amountOfFingers = event?.touches(for: self)?.count, amountOfFingers != fingers {
            incorrect("feedback_fingers".localized(fingers, amountOfFingers))
        } else {
            incorrect("feedback_zigzag".localized)
        }
    }
}
