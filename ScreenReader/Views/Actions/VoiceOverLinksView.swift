//
//  VoiceOverLinksView.swift
//  Appt
//
//  Created by Jan Jaap de Groot on 02/09/2020.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import UIKit

class VoiceOverLinksView: VoiceOverView {
    
    @IBOutlet private var textView: UITextView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textView.font = .openSans(weight: .regular, size: 18, style: .body)
        textView.delegate = self
    }
    
    override func onFocusChanged(_ elements: [UIAccessibilityElement]) {
        let count = elements.count
        
        guard count >= 3 else { return }
        
        // Check if the last three elements contain the `link` accessibility trait
        if elements.dropFirst(count-3).allSatisfy({ $0.accessibilityTraits.contains(.link) }) {
            delegate?.correct(action)
        }
    }
}

// MARK: - UITextViewDelegate

extension VoiceOverLinksView: UITextViewDelegate {
    
    // Ignore interactions with links to avoid unwanted actions
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            Alert.toast("action_interaction_disabled".localized, duration: 2.5, viewController: viewController)
        }
        return false
    }
}
