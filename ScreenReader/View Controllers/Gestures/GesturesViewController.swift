//
//  GesturesViewController.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class GesturesViewController: TableViewController {

    private var gestures: KeyValuePairs<String, [Gesture]> {
        return [
            "gestures_one_finger_swipe".localized: [
                .oneFingerTouch,
                .oneFingerSwipeRight,
                .oneFingerSwipeLeft,
                .oneFingerSwipeUp,
                .oneFingerSwipeDown
            ],
            "gestures_two_finger_swipe".localized: [
                .twoFingerSwipeUp,
                .twoFingerSwipeDown,
            ],
            "gestures_three_finger_swipe".localized: [
                .threeFingerSwipeUp,
                .threeFingerSwipeDown,
                .threeFingerSwipeRight,
                .threeFingerSwipeLeft
            ],
            "gestures_one_finger_tap".localized: [
                .oneFingerDoubleTap,
                .oneFingerDoubleTapHold,
                .oneFingerTripleTap
            ],
            "gestures_two_finger_tap".localized: [
                .twoFingerTap,
                .twoFingerDoubleTap,
                .twoFingerDoubleTapHold,
                .twoFingerTripleTap,
            ],
            "gestures_three_finger_tap".localized: [
                .threeFingerTap,
                .threeFingerDoubleTap,
                .threeFingerTripleTap,
            ],
            "gestures_four_finger_tap".localized: [
                .fourFingerTapTop,
                .fourFingerTapBottom
            ],
            "gestures_shortcuts".localized: [
                .twoFingerRotate,
                .twoFingerZShape,
                .oneFingerInteraction,
            ]
        ]
    }
    
    private var lastSelectedRow: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set-up UITableView
        tableView.registerNib(TitleTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
        
    @IBAction private func onPracticeTapped(_ sender: Any) {
        Alert.Builder()
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
        
        // Reset completion status
        gestures.forEach { gesture in
            UserDefaults.standard.setValue(false, forKey: gesture.id)
        }
        
        let vc = UIStoryboard.voiceOverGesture(gestures: gestures, instructions: instructions)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableView

extension GesturesViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return gestures.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return gestures[section].key
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gestures[section].value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(TitleTableViewCell.self, at: indexPath)
        
        let gesture = gestures[indexPath.section].value[indexPath.row]
        cell.setup(gesture)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension GesturesViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastSelectedRow = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
        
        let gesture = gestures[indexPath.section].value[indexPath.row]
        let vc = UIStoryboard.voiceOverGesture(gesture: gesture)
        navigationController?.pushViewController(vc, animated: true)
    }
}
