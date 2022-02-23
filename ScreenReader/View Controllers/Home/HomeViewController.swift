//
//  HomeViewController.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class HomeViewController: TextTableViewController {
    
    override var items: [Any] {
        get {
            return [
                "home_description".localized,
                Header("home_section_1".localized),
                "home_section_1_paragraph_1".localized,
                Header("home_section_2".localized),
                "home_section_2_paragraph_1".localized,
                Header("home_section_3".localized),
                "home_section_3_paragraph_1".localized,
                "home_section_3_paragraph_2".localized,
                "home_section_3_paragraph_3".localized,
                "home_section_3_paragraph_4".localized,
                Header("home_section_4".localized),
                "home_section_4_paragraph_1".localized,
                Header("home_section_5".localized),
                "home_section_5_paragraph_1".localized,
                Header("home_section_6".localized),
                "home_section_6_paragraph_1".localized,
                Header("home_section_7".localized),
                "home_section_7_paragraph_1".localized
            ]
        }
    }

    @IBAction private func onShareTapped(_ sender: Any) {
        shareApp()
    }
}
