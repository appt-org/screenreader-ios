//
//  PasteAction.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 25/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import Foundation

class PasteAction: Action {
    
    let identifier = "paste"
    
    let items: [Any] = [
        "action_paste_paragraph_1".localized,
        Header("action_paste_section_1".localized),
        "action_paste_section_1_paragraph_1".localized,
        "action_paste_section_1_paragraph_2".localized,
        "action_paste_section_1_paragraph_3".localized,
        "action_paste_section_1_paragraph_4".localized,
        "action_paste_section_1_paragraph_5".localized,
        Header("action_paste_section_2".localized),
        "action_paste_section_2_paragraph_1".localized,
        Input(placeholder: "action_paste_section_2_placeholder".localized)
    ]
    
    func onTextPasted(_ textField: TextField, text: String?) -> Bool {
        guard let text = text else {
            return false
        }
        return text.count > 1
    }
}
