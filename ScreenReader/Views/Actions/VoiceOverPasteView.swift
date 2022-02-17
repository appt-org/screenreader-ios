//
//  VoiceOverPasteView.swift
//  Appt
//
//  Created by Jan Jaap de Groot on 09/09/2020.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import UIKit

class VoiceOverPasteView: VoiceOverView {
    
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
        textField.delegate = self
    }
}

// MARK: - UITextFieldDelegate

extension VoiceOverPasteView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.count > 1 {
            delegate?.correct(action)
        }
        return true
    }
}
