//
//  TextTableViewCell.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    
    @IBOutlet private var textView: TextView!
    
    @IBOutlet var topConstraint: NSLayoutConstraint!
    @IBOutlet var rightConstraint: NSLayoutConstraint!
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    @IBOutlet var leftConstraint: NSLayoutConstraint!
    
    func setup(_ text: String, top: CGFloat? = nil, right: CGFloat? = nil, bottom: CGFloat? = nil, left: CGFloat? = nil) {
        textView.font = .openSans(weight: .regular, size: 18, style: .body)
        textView.text = text
        
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.dataDetectorTypes = .all
        
        constraint(top: top, right: right, bottom: bottom, left: left)
        
        selectionStyle = .none
        
        if #available(iOS 13.0, *) {
            accessibilityRespondsToUserInteraction = true
        }
    }
    
    func constraint(top: CGFloat? = nil, right: CGFloat? = nil, bottom: CGFloat? = nil, left: CGFloat? = nil) {
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
    }
}
