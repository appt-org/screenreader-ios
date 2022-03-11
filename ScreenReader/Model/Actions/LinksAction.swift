//
//  LinksAction.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 25/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class LinksAction: Action {
    
    let identifier = "links"
    
    let items: [Any] = [
        "action_links_paragraph_1".localized,
        Header("action_links_section_1".localized),
        "action_links_section_1_paragraph_1".localized,
        "action_links_section_1_paragraph_2".localized,
        "action_links_section_1_paragraph_3".localized,
        "action_links_section_1_paragraph_4".localized,
        Header("action_links_section_2".localized),
        "action_links_section_2_paragraph_1".localized
    ]
    
    func onFocusChanged(_ elements: [UIAccessibilityElement]) -> Bool {
        let count = elements.count
        
        guard count >= 3 else {
            return false
        }
        
        // Check if the last three elements are link elements
        return elements.dropFirst(count-3).allSatisfy({
            String(describing: $0).contains("UIAccessibilityLinkSubelement")
        })
    }
}
