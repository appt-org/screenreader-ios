//
//  HeadingsAction.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 25/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class HeadingsAction: Action {
    
    let identifier = "headings"
    
    let items: [Any] = [
        "action_headings_paragraph_1".localized,
        Header("action_headings_section_1".localized),
        "action_headings_section_1_paragraph_1".localized,
        "action_headings_section_1_paragraph_2".localized,
        "action_headings_section_1_paragraph_3".localized,
        Header("action_headings_header_1".localized),
        "action_headings_header_1_text".localized,
        Header("action_headings_header_2".localized),
        "action_headings_header_2_text".localized,
        Header("action_headings_header_3".localized),
        "action_headings_header_3_text".localized,
    ]
    
    func onFocusChanged(_ views: [UIView]) -> Bool {
        let count = views.count

        guard count >= 3 else {
            return false
        }
        
        // Check if the last three views are HeaderTableViewCell
        if views.dropFirst(count-3).allSatisfy({
            $0 is HeaderTableViewCell
        }) {
            return true
        }
        
        return false
    }
}
