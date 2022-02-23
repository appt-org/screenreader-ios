//
//  TitleTableViewCell.swift
//  Meldpunt
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    override var accessibilityTraits: UIAccessibilityTraits {
        get {
            return .button
        } set {
            // Ignored to maintain `button` trait at all times.
        }
    }
    
    @IBOutlet private var titleLabel: UILabel!
        
    func setup(_ title: String) {
        titleLabel.font = .openSans(weight: .regular, size: 18, style: .body)
        titleLabel.text = title
        titleLabel.textColor = .foreground
        
        accessoryType = .disclosureIndicator
        
        shouldGroupAccessibilityChildren = true
        accessibilityLabel = title
    }
    
    func setup(_ item: Item) {
        setup(item.title)
        
        if let learning = item as? Learning {
            accessibilityValue = learning.completed ? "completed".localized : nil
            accessoryType = learning.completed ? .checkmark : .disclosureIndicator
        }
    }
}
