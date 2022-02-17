//
//  VoiceOverHeadingsView.swift
//  Appt
//
//  Created by Jan Jaap de Groot on 27/08/2020.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import UIKit

class VoiceOverHeadingsView: VoiceOverView {
    
    @IBOutlet private var stackView: UIStackView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.subviews.forEach { (view) in
            if let label = view as? UILabel {
                if label.accessibilityTraits.contains(.header) {
                    label.font = .openSans(weight: .bold, size: 20, style: .headline)
                } else {
                    label.font = .openSans(weight: .regular, size: 18, style: .body)
                }
            }
        }
    }

    override func onFocusChanged(_ views: [UIView]) {
        let count = views.count
        
        guard count >= 3 else { return }
        
        // Check if the last three views contain the `header` accessibility trait
        if views.dropFirst(count-3).allSatisfy({ $0.accessibilityTraits.contains(.header) }) {
            delegate?.correct(action)
        }
    }
}
