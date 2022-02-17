//
//  VoiceOverView.swift
//  Appt
//
//  Created by Jan Jaap de Groot on 27/08/2020.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import UIKit

protocol VoiceOverViewDelegate {
    func correct(_ action: Action)
    func incorrect(_ action: Action)
}

class VoiceOverView: UIView {

    var delegate: VoiceOverViewDelegate?
    var action: Action!
    
    private var focusedElements = [UIAccessibilityElement]()
    private var focusedViews = [UIView]()
    
    class func create<T: VoiceOverView>(_ action: Action) -> T {
        let view:T = self.fromNib()
        view.action = action
        return view
    }
    
    // Called from the ViewController
    func elementFocusedNotification(_ notification: Notification) {
        guard let object = notification.userInfo?[UIAccessibility.focusedElementUserInfoKey] else {
            return
        }
        
        if let element = object as? UIAccessibilityElement {
            focusedElements.append(element)
            onFocusChanged(focusedElements)
        }
        
        if let view = object as? UIView {
            focusedViews.append(view)
            onFocusChanged(focusedViews)
        }
    }
    
    func onFocusChanged(_ elements: [UIAccessibilityElement]) {
        // Can be overridden in subclass
    }
    
    func onFocusChanged(_ views: [UIView]) {
        // Can be overridden in subclass
    }
    
    // Called from ViewController
    func pasteboardChangedNotification(_ notification: Notification) {
        onPasteboardChanged(UIPasteboard.general.string)
    }
    
    func onPasteboardChanged(_ content: String?) {
        // Can be overridden in subclass
    }
}
