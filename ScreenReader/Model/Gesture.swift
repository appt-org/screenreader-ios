//
//  Gesture.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 17/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

enum Gesture: String, CaseIterable {
    
    // One finger swipe
    case oneFingerTouch         = "one_finger_touch"
    case oneFingerSwipeRight    = "one_finger_swipe_right"
    case oneFingerSwipeLeft     = "one_finger_swipe_left"
    case oneFingerSwipeUp       = "one_finger_swipe_up"
    case oneFingerSwipeDown     = "one_finger_swipe_down"
    
    // Two finger swipe
    case twoFingerSwipeDown     = "two_finger_swipe_down"
    case twoFingerSwipeUp       = "two_finger_swipe_up"
    
    // Three finger swipe
    case threeFingerSwipeUp     = "three_finger_swipe_up"
    case threeFingerSwipeDown   = "three_finger_swipe_down"
    case threeFingerSwipeRight  = "three_finger_swipe_right"
    case threeFingerSwipeLeft   = "three_finger_swipe_left"
    
    // One finger tap
    case oneFingerDoubleTap     = "one_finger_double_tap"
    case oneFingerDoubleTapHold = "one_finger_double_tap_hold"
    case oneFingerTripleTap     = "one_finger_triple_tap"
    
    // Two finger tap
    case twoFingerTap           = "two_finger_tap"
    case twoFingerDoubleTap     = "two_finger_double_tap"
    case twoFingerDoubleTapHold = "two_finger_double_tap_hold"
    case twoFingerTripleTap     = "two_finger_triple_tap"
    
    // Three finger tap
    case threeFingerTap         = "three_finger_tap"
    case threeFingerDoubleTap   = "three_finger_double_tap"
    case threeFingerTripleTap   = "three_finger_triple_tap"
    
    // Four finger tap
    case fourFingerTapTop       = "four_finger_tap_top"
    case fourFingerTapBottom    = "four_finger_tap_bottom"
    
    // Shortcuts
    case twoFingerRotate        = "two_finger_rotate"
    case twoFingerZShape        = "two_finger_z_shape"
    case oneFingerInteraction   = "one_finger_interaction"
    
    /** Identifier */
    var id: String {
        return rawValue
    }
    
    /** Title */
    var title: String {
        return NSLocalizedString("gesture_"+rawValue+"_title", comment: "")
    }
            
    /** Description */
    var description: String {
        return NSLocalizedString("gesture_"+rawValue+"_description", comment: "")
    }
    
    /** Explanation */
    var explanation: String {
        return NSLocalizedString("gesture_"+rawValue+"_explanation", comment: "")
    }
    
    /** Image */
    var image: UIImage? {
        return UIImage(named: "gesture_" + rawValue)
    }
    
    /** View */
    var view: GestureView {
        switch self {
        case .oneFingerTouch:
            return TouchGestureView(gesture: self, taps: 1, fingers: 1)
        case .oneFingerSwipeRight:
            return SwipeGestureView(gesture: self, direction: .right, fingers: 1)
        case .oneFingerSwipeLeft:
            return SwipeGestureView(gesture: self, direction: .left, fingers: 1)
        case .oneFingerSwipeUp:
            return SwipeGestureView(gesture: self, direction: .up, fingers: 1)
        case .oneFingerSwipeDown:
            return SwipeGestureView(gesture: self, direction: .down, fingers: 1)
            
        case .twoFingerSwipeUp:
            return SwipeGestureView(gesture: self, direction: .up, fingers: 2)
        case .twoFingerSwipeDown:
            return SwipeGestureView(gesture: self, direction: .down, fingers: 2)
            
        case .threeFingerSwipeUp:
            return SwipeGestureView(gesture: self, direction: .up, fingers: 3)
        case .threeFingerSwipeDown:
            return SwipeGestureView(gesture: self, direction: .down, fingers: 3)
        case .threeFingerSwipeRight:
            return SwipeGestureView(gesture: self, direction: .right, fingers: 3)
        case .threeFingerSwipeLeft:
            return SwipeGestureView(gesture: self, direction: .left, fingers: 3)
            
        case .oneFingerDoubleTap:
            return TapGestureView(gesture: self, taps: 2, fingers: 1)
        case .oneFingerDoubleTapHold:
            return LongPressGestureView(gesture: self, taps: 2, fingers: 1)
        case .oneFingerTripleTap:
            return TapGestureView(gesture: self, taps: 3, fingers: 1)
            
        case .fourFingerTapTop:
            return TapGestureView(gesture: self, taps: 1, fingers: 4, position: .top)
        case .fourFingerTapBottom:
            return TapGestureView(gesture: self, taps: 1, fingers: 4, position: .bottom)
        
        case .twoFingerTap:
            return TapGestureView(gesture: self, taps: 1, fingers: 2)
        case .twoFingerDoubleTap:
            return TapGestureView(gesture: self, taps: 2, fingers: 2)
        case .twoFingerDoubleTapHold:
            return LongPressGestureView(gesture: self, taps: 2, fingers: 2)
        case .twoFingerTripleTap:
            return TapGestureView(gesture: self, taps: 3, fingers: 2)
            
        case .threeFingerTap:
            return TapGestureView(gesture: self, taps: 1, fingers: 3)
        case .threeFingerDoubleTap:
            return TapGestureView(gesture: self, taps: 2, fingers: 3)
        case .threeFingerTripleTap:
            return TapGestureView(gesture: self, taps: 3, fingers: 3)
        
        case .twoFingerRotate:
            return RotationGestureView(gesture: self, fingers: 2, rotation: 0.5)
        case .twoFingerZShape:
            return EscapeGestureView(gesture: self, fingers: 2)
        case .oneFingerInteraction:
            return DirectGestureView(gesture: self)
        }
    }
    
    /** Completion state */
    var completed: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: id)
        }
        get {
            return UserDefaults.standard.bool(forKey: id)
        }
    }
    
    static func shuffled() -> [Gesture] {
        var gestures = allCases
        gestures.shuffle()
        return gestures
    }
}
