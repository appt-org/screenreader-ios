//
//  ActionViewController2.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 23/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class ActionViewController2: TableViewController {
    
    var action: Action!
    
    private var focusedElements = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = action.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self, selector: #selector(voiceOverStatusNotification), name: UIAccessibility.voiceOverStatusDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(elementFocusedNotification), name: UIAccessibility.elementFocusedNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pasteboardChangedNotification), name: UIPasteboard.changedNotification, object: nil)
    }
    
    @objc private func voiceOverStatusNotification(_ notification: Notification) {
        guard UIAccessibility.isVoiceOverRunning else {
            Alert.Builder()
                .title("action_voiceover_disabled".localized)
                .message("action_voiceover_enable".localized)
                .okAction() {
                    self.navigationController?.popViewController(animated: true)
                }.present(in: self)
            return
        }
    }
    
    @objc private func elementFocusedNotification(_ notification: Notification) {
        focusedElements += 1
        //actionView.elementFocusedNotification(notification)
    }
    
    @objc private func pasteboardChangedNotification(_ notification: Notification){
        //actionView.pasteboardChangedNotification(notification)
    }
}

// MARK: - Keyboard

extension ActionViewController2 {
    
    override func keyboardWillShow(frame: CGRect, notification: Notification) {
        var contentInset = tableView.contentInset
        contentInset.bottom = frame.size.height
        tableView.contentInset = contentInset
    }
    
    override func keyboardWillHide(notification: Notification) {
        tableView.contentInset = .zero
        tableView.scrollIndicatorInsets = .zero
    }
}

// MARK: - VoiceOverViewDelegate

extension ActionViewController2: VoiceOverViewDelegate {
    
    func correct(_ action: Action) {
        self.action.completed = true
        //Events.log(.actionCompleted, identifier: action.id, value: focusedElements)
        
        Alert.toast("action_completed".localized, duration: 3.0, viewController: self) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func incorrect(_ action: Action) {
        // Ignored
    }
}
