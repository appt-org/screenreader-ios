//
//  VoiceOverActionViewController.swift
//  Appt
//
//  Created by Jan Jaap de Groot on 31/08/2020.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import Foundation
import UIKit
import AVKit
import Accessibility

class ActionViewController: ScrollViewController {
    
    var action: Action!
    lazy var actionView: VoiceOverView = {
        return action.view
    }()
    
    private var focusedElements = 0
    
    override func getView() -> UIView {
        return actionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = action.title
        actionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard UIAccessibility.isVoiceOverRunning else {
            Alert.Builder()
                .title("action_voiceover_disabled".localized)
                .message("action_voiceover_enable".localized)
                .okAction() {
                    self.navigationController?.popViewController(animated: true)
                }.present(in: self)
            return
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(elementFocusedNotification), name: UIAccessibility.elementFocusedNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pasteboardChangedNotification), name: UIPasteboard.changedNotification, object: nil)
    }
    
    @objc func elementFocusedNotification(_ notification: Notification) {
        focusedElements += 1
        actionView.elementFocusedNotification(notification)
    }
    
    @objc func pasteboardChangedNotification(_ notification: Notification){
        actionView.pasteboardChangedNotification(notification)
    }
}

// MARK: - Keyboard

extension ActionViewController {
    
    override func keyboardWillShow(frame: CGRect, notification: Notification) {
        var contentInset = scrollView.contentInset
        contentInset.bottom = frame.size.height
        scrollView.contentInset = contentInset
    }
    
    override func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
}

// MARK: - VoiceOverViewDelegate

extension ActionViewController: VoiceOverViewDelegate {
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
