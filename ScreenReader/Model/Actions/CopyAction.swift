//
//  CopyAction.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 25/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class CopyAction: Action {
    
    let identifier = "copy"
    
    let items: [Any] = [
        "action_copy_paragraph_1".localized,
        Header("action_copy_section_1".localized),
        "action_copy_section_1_paragraph_1".localized,
        "action_copy_section_1_paragraph_2".localized,
        "action_copy_section_1_paragraph_3".localized,
        "action_copy_section_1_paragraph_4".localized,
        "action_copy_section_1_paragraph_5".localized,
        "action_copy_section_1_paragraph_6".localized,
        "action_copy_section_1_paragraph_7".localized,
        "action_copy_section_1_paragraph_8".localized,
        Header("action_copy_section_2".localized),
        "action_copy_section_2_paragraph_1".localized,
        Input(placeholder: "action_copy_section_2_placeholder".localized, text: "action_copy_section_2_text".localized)
    ]
    
    func onPasteboardChanged(_ content: String?) -> Bool {
        guard let content = content,
              let input = items.last as? Input else {
            return false
        }
        return input.text?.contains(content) == true
    }
}
