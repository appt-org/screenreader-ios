//
//  VoiceOverCopyView.swift
//  Appt
//
//  Created by Jan Jaap de Groot on 09/09/2020.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import UIKit

class VoiceOverCopyView: VoiceOverView {
    
    @IBOutlet private var stackView: UIStackView!
    @IBOutlet private var textField: UITextField!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.subviews.forEach { (view) in
            if let label = view as? UILabel {
                label.font = .openSans(weight: .regular, size: 18, style: .body)
            }
        }
        
        textField.font = .openSans(weight: .bold, size: 20, style: .body)
        textField.inputView = UIView()
    }
    
    override func onPasteboardChanged(_ content: String?) {
        if let content = content, let text = textField.text, text.contains(content) {
            delegate?.correct(action)
        }
    }
}
