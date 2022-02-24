//
//  Input.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 24/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import Foundation

class Input {
    
    var placeholder: String
    var text: String
    
    init(placeholder: String, text: String) {
        self.placeholder = placeholder
        self.text = text
    }
}
