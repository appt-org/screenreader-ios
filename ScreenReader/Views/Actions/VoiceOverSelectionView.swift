//
//  VoiceOverSelectionView.swift
//  Appt
//
//  Created by Jan Jaap de Groot on 21/09/2020.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import UIKit

class VoiceOverSelectionView: VoiceOverView {
    
    @IBOutlet private var stackView: UIStackView!
    @IBOutlet private var textField: TextField!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.subviews.forEach { (view) in
            if let label = view as? UILabel {
                if label.accessibilityTraits.contains(.header) {
                    label.font = .openSans(weight: .bold, size: 20, style: .body)
                } else {
                    label.font = .openSans(weight: .regular, size: 18, style: .body)
                }
            }
        }
        
        textField.font = .openSans(weight: .bold, size: 20, style: .body)
        textField.inputView = UIView()
        textField.selection = self
    }
}

// MARK: - TextFieldDelegate

extension VoiceOverSelectionView: TextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: TextField, range: UITextRange?) {
        if let range = range {
            let length = textField.offset(from: range.start, to: range.end)
            
            if length > 0 {
                delegate?.correct(action)
            }
        }
    }
}
