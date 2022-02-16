//
//  HeaderTableViewCell.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet private var label: UILabel!
        
    @IBOutlet var topConstraint: NSLayoutConstraint!
    @IBOutlet var rightConstraint: NSLayoutConstraint!
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    @IBOutlet var leftConstraint: NSLayoutConstraint!
    
    func setup(_ text: String, top: CGFloat? = nil, right: CGFloat? = nil, bottom: CGFloat? = nil, left: CGFloat? = nil) {
        label.isAccessibilityElement = false
        label.font = .openSans(weight: .bold, size: 18, style: .body)
        label.text = text
        
        if let top = top {
            topConstraint.constant = top
        }
        if let right = right {
            rightConstraint.constant = right
        }
        if let bottom = bottom {
            bottomConstraint.constant = bottom
        }
        if let left = left {
            leftConstraint.constant = left
        }
        
        accessibilityLabel = text
        accessibilityTraits = .header
        
        selectionStyle = .none
    }
}
