//
//  GesturesViewController.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class GesturesViewController: TableViewController {

    @IBOutlet private var practiceItem: UIBarButtonItem!
    
    override var items: [Any] {
        get {
            return [
                "gestures_description".localized,
                Header("gestures_one_finger_swipe".localized),
                Gesture.oneFingerTouch,
                Gesture.oneFingerSwipeRight,
                Gesture.oneFingerSwipeLeft,
                Gesture.oneFingerSwipeUp,
                Gesture.oneFingerSwipeDown,
                Header("gestures_two_finger_swipe".localized),
                Gesture.twoFingerSwipeUp,
                Gesture.twoFingerSwipeDown,
                Header("gestures_three_finger_swipe".localized),
                Gesture.threeFingerSwipeUp,
                Gesture.threeFingerSwipeDown,
                Gesture.threeFingerSwipeRight,
                Gesture.threeFingerSwipeLeft,
                Header("gestures_one_finger_tap".localized),
                Gesture.oneFingerDoubleTap,
                Gesture.oneFingerDoubleTapHold,
                Gesture.oneFingerTripleTap,
                Header("gestures_two_finger_tap".localized),
                Gesture.twoFingerTap,
                Gesture.twoFingerDoubleTap,
                Gesture.twoFingerDoubleTapHold,
                Gesture.twoFingerTripleTap,
                Header("gestures_three_finger_tap".localized),
                Gesture.threeFingerTap,
                Gesture.threeFingerDoubleTap,
                Gesture.threeFingerTripleTap,
                Header("gestures_four_finger_tap".localized),
                Gesture.fourFingerTapTop,
                Gesture.fourFingerTapBottom,
                Header("gestures_shortcuts".localized),
                Gesture.twoFingerRotate,
                Gesture.twoFingerZShape,
                Gesture.oneFingerInteraction
            ]
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "gestures_title".localized
        navigationController?.tabBarItem.title = "gestures_tab".localized
        
        practiceItem.title = "practice".localized
    }
    
    @IBAction private func onPracticeTapped(_ sender: Any) {
        Alert.Builder()
            .title("gestures_practice_title".localized)
            .message("gestures_practice_message".localized)
            .action("gestures_practice_positive".localized) {
                self.practice(true)
            }
            .action("gestures_practice_negative".localized) {
                self.practice(false)
            }
            .cancelAction()
            .present(in: self)
    }
    
    private func practice(_ instructions: Bool) {
        let gestures = Gesture.shuffled()
        
        let vc = UIStoryboard.gestures(gestures, instructions: instructions)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didSelectItem(_ item: Any, indexPath: IndexPath) {
        guard let gesture = item as? Gesture else {
            return
        }
        
        let vc = UIStoryboard.gesture(gesture)
        navigationController?.pushViewController(vc, animated: true)
    }
}
