//
//  MoreViewController.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class MoreViewController: TableViewController {
    
    override var items: [Any] {
        get {
            return [
                "more_description".localized,
                Topic.rating,
                Topic.share,
                Header("more_partners".localized),
                Topic.appt,
                Topic.abra,
                Topic.sidnFonds
            ]
        }
    }
    
    @IBAction private func onShareTapped(_ sender: Any) {
        shareApp()
    }
    
    override func didSelectItem(_ item: Any, indexPath: IndexPath) {
        guard let topic = item as? Topic else {
            return
        }
        
        if topic == .rating, let url = URL(string: topic.website) {
            UIApplication.shared.open(url, options: [:])
        } else if topic == .share {
            shareApp()
        } else {
            openWebsite(topic.website)
        }
    }
}
