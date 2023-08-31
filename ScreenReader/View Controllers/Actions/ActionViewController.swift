//
//  ActionViewController.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 23/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class ActionViewController: TextTableViewController {
    
    private let startTime = Date().timeIntervalSince1970
    
    var action: Action!
    override var items: [Any] {
        get {
            return action.items
        }
    }
    
    private var focusedElements = [UIAccessibilityElement]()
    private var focusedViews = [UIView]()
    
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
    
    // MARK: - Focus
    
    @objc private func elementFocusedNotification(_ notification: Notification) {
        guard let object = notification.userInfo?[UIAccessibility.focusedElementUserInfoKey] else {
            return
        }
        
        if let element = object as? UIAccessibilityElement {
            focusedElements.append(element)
            onFocusChanged(focusedElements)
            
            // Find view on screen
            guard let coordinate = UIApplication.shared.keyWindow?.convert(element.accessibilityFrame.origin, to: tableView),
                  let indexPath = tableView.indexPathForRow(at: coordinate),
                  let cell = tableView.cellForRow(at: indexPath) else {
                return
            }
            
            // Avoid duplicates
            if let lastView = focusedViews.last, lastView == cell {
                return
            }
            
            focusedViews.append(cell)
            onFocusChanged(focusedViews)
        } else if let view = object as? UIView {
            focusedViews.append(view)
            onFocusChanged(focusedViews)
        }
    }
    
    private func onFocusChanged(_ elements: [UIAccessibilityElement]) {
        if action.onFocusChanged(elements) {
            correct()
        }
    }
    
    private func onFocusChanged(_ views: [UIView]) {
        if action.onFocusChanged(views) {
            correct()
        }
    }
        
    // MARK: - Pasteboard
    
    @objc private func pasteboardChangedNotification(_ notification: Notification) {
        onPasteboardChanged(UIPasteboard.general.string)
    }
    
    private func onPasteboardChanged(_ content: String?) {
        if action.onPasteboardChanged(content) {
            correct()
        }
    }
    
    // MARK: - Status
    
    func correct() {
        self.action.completed = true
        
        let elapsedTime = Int(Date().timeIntervalSince1970 - startTime)
        Events.log(.action_completed, identifier: action.identifier, value: elapsedTime)
        
        Alert.toast("action_completed".localized, duration: 3.0, viewController: self) {
            self.navigationController?.popViewController(animated: true)
            self.requestReview()
        }
    }
    
    // MARK: - Cell
    
    override func inputTableViewCell(_ input: Input, indexPath: IndexPath) -> InputTableViewCell {
        let cell = super.inputTableViewCell(input, indexPath: indexPath)
        cell.delegate = self
        return cell
    }
}

// MARK: - TextFieldDelegate

extension ActionViewController: TextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: TextField, range: UITextRange?) {
        if action.onTextSelected(textField, range: range) {
            correct()
        }
    }
    
    func textFieldDidPasteText(_ textField: TextField, text: String?) {
        if action.onTextPasted(textField, text: text) {
            correct()
        }
    }
}

// MARK: - Keyboard

extension ActionViewController {
    
    override func keyboardWillShow(height: CGFloat) {
        var contentInset = tableView.contentInset
        contentInset.bottom = height
        tableView.contentInset = contentInset
    }
        
    override func keyboardWillHide() {
        tableView.contentInset = .zero
        tableView.scrollIndicatorInsets = .zero
    }
}
