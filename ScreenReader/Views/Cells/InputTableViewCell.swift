//
//  InputTableViewCell.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 24/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class InputTableViewCell: UITableViewCell {
    
    @IBOutlet private var textField: TextField!
    
    var delegate: TextFieldDelegate?
    
    func setup(placeholder: String? = nil, text: String? = nil) {
        textField.font = .openSans(weight: .regular, size: 18)
        textField.placeholder = placeholder
        textField.text = text
        textField.textFieldDelegate = delegate
    }
    
    func setup(_ input: Input) {
        self.setup(placeholder: input.placeholder, text: input.text)
    }
}
