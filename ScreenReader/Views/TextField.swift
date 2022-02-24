//
//  TextField.swift
//  Appt
//
//  Created by Jan Jaap de Groot on 01/10/2020.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import UIKit

protocol TextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: TextField, range: UITextRange?)
}

class TextField: UITextField {
    
    var selection: TextFieldDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        backgroundColor = .background
        textColor = .foreground
        tintColor = .primary
        font = .openSans(weight: .regular, size: 18, style: .body)
        
        layer.cornerRadius = 8
        layer.borderWidth = 2
        layer.borderColor = UIColor.foreground.cgColor
    }
    
    // MARK: - Padding
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 12)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    // MARK: - Text range
    
    // Custom protocol to support iOS versions lower than 13.
    override var selectedTextRange: UITextRange? {
        get {
            return super.selectedTextRange}
        set {
            selection?.textFieldDidChangeSelection(self, range: newValue)
            super.selectedTextRange = newValue
        }
    }
}
