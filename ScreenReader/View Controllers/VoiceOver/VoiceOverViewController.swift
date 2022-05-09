//
//  VoiceOverViewController.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class VoiceOverViewController: TextTableViewController {
    
    override var items: [Any] {
        get {
            return [
                "voiceover_description".localized,
                Header("voiceover_section_1".localized),
                "voiceover_section_1_paragraph_1".localized,
                "voiceover_section_1_paragraph_2".localized,
                "voiceover_section_1_paragraph_3".localized,
                Header("voiceover_section_2".localized),
                "voiceover_section_2_paragraph_1".localized,
                "voiceover_section_2_paragraph_2".localized,
                "voiceover_section_2_paragraph_3".localized,
                Header("voiceover_section_3".localized),
                "voiceover_section_3_paragraph_1".localized,
                "voiceover_section_3_paragraph_2".localized,
                "voiceover_section_3_paragraph_3".localized,
                Header("voiceover_section_4".localized),
                "voiceover_section_4_paragraph_1".localized,
                "voiceover_section_4_paragraph_2".localized,
                Header("voiceover_section_5".localized),
                "voiceover_section_5_paragraph_1".localized,
                "voiceover_section_5_paragraph_2".localized,
                "voiceover_section_5_paragraph_3".localized
            ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "voiceover_title".localized
    }
}
