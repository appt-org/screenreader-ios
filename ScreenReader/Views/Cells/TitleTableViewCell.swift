//
//  TitleTableViewCell.swift
//  Meldpunt
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    @IBOutlet private var titleLabel: UILabel!
        
    func setup(_ title: String) {
        titleLabel.font = .openSans(weight: .regular, size: 18, style: .body)
        titleLabel.text = title
        titleLabel.textColor = .foreground
        
        accessoryType = .disclosureIndicator
        
        accessibilityTraits = .button
        shouldGroupAccessibilityChildren = true
        accessibilityLabel = title
    }
    
    func setup(_ item: Item) {
        setup(item.title)
    }
    
    func setup(_ gesture: Gesture) {
        titleLabel.font = .openSans(weight: .regular, size: 18, style: .body)
        titleLabel.text = gesture.title
        
        accessibilityLabel = gesture.title
        accessibilityValue = gesture.completed ? "Afgerond" : nil
        accessoryType = gesture.completed ? .checkmark : .disclosureIndicator
        accessibilityHint = "Dubbeltik met twee vingers om dit gebaar te oefenen"
    }
}
