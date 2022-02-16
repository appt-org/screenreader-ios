//
//  TextTableViewCell.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    
    @IBOutlet private var label: UILabel!
        
    @IBOutlet private var topConstraint: NSLayoutConstraint!
    @IBOutlet private var rightConstraint: NSLayoutConstraint!
    @IBOutlet private var bottomConstraint: NSLayoutConstraint!
    @IBOutlet private var leftConstraint: NSLayoutConstraint!
    
    func setup(_ text: String, top: CGFloat? = nil, right: CGFloat? = nil, bottom: CGFloat? = nil, left: CGFloat? = nil) {
        label.font = .openSans(weight: .regular, size: 18, style: .body)
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
        
        selectionStyle = .none
    }
}
