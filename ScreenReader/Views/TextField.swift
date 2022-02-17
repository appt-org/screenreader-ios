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
