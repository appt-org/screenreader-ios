//
//  SelectionAction.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 25/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class SelectionAction: Action {
    
    let identifier = "selection"
        
    let items: [Any] = [
        "action_selection_paragraph_1".localized,
        Header("action_selection_section_1".localized),
        "action_selection_section_1_paragraph_1".localized,
        "action_selection_section_1_paragraph_2".localized,
        "action_selection_section_1_paragraph_3".localized,
        "action_selection_section_1_paragraph_4".localized,
        "action_selection_section_1_paragraph_5".localized,
        Header("action_selection_section_2".localized),
        "action_selection_section_2_paragraph_1".localized,
        "action_selection_section_2_paragraph_2".localized,
        "action_selection_section_2_paragraph_3".localized,
        "action_selection_section_2_paragraph_4".localized,
        "action_selection_section_2_paragraph_5".localized,
        "action_selection_section_2_paragraph_6".localized,
        Header("action_selection_section_3".localized),
        "action_selection_section_3_paragraph_1".localized,
        Input(placeholder: "action_selection_section_3_placeholder".localized, text: "action_selection_section_3_text".localized)
    ]
    
    func onTextSelected(_ textField: TextField, range: UITextRange?) -> Bool {
        guard let range = range else {
            return false
        }
        
        return textField.offset(from: range.start, to: range.end) > 0
    }
}
