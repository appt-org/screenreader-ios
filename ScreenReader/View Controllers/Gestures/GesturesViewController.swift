//
//  GesturesViewController.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class GesturesViewController: TableViewController {

    private let items: [Any] = [
        "Op dit scherm kun je alle VoiceOver gebaren leren, van makkelijk tot moeilijk. Via de knop rechtsbovenaan kun je de gebaren door elkaar oefenen.",
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
    
    private var lastSelectedRow: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set-up UITableView
        tableView.registerNib(HeaderTableViewCell.self)
        tableView.registerNib(TextTableViewCell.self)
        tableView.registerNib(TitleTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
        
    @IBAction private func onPracticeTapped(_ sender: Any) {
        Alert.Builder()
            .title("gestures_practice_message".localized)
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
        
        let vc = UIStoryboard.gestures(gestures, instructions: instructions)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableView

extension GesturesViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        if let string = item as? String {
            let cell = tableView.cell(TextTableViewCell.self, at: indexPath)
            cell.setup(string)
            return cell
        } else if let header = item as? Header {
            let cell = tableView.cell(HeaderTableViewCell.self, at: indexPath)
            cell.setup(header.text)
            return cell
        } else if let gesture = item as? Gesture {
            let cell = tableView.cell(TitleTableViewCell.self, at: indexPath)
            cell.setup(gesture)
            return cell
        }
        
        fatalError("Cell for object \(item) not implemented")
    }
}

// MARK: - UITableViewDelegate

extension GesturesViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastSelectedRow = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let gesture = items[indexPath.row] as? Gesture else {
            return
        }
        
        let vc = UIStoryboard.gesture(gesture)
        navigationController?.pushViewController(vc, animated: true)
    }
}
