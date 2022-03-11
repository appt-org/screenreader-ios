//
//  TextView.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 09/03/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class TextView: UITextView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        delegate = self
         
        // Remove padding
        textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textContainer.lineFragmentPadding = 0
    }
}

// MARK: - UITextViewDelegate

extension TextView: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return false // Disable URL interaction
    }
}
