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
                Header("more_actions".localized),
                Topic.rating,
                Topic.share,
                Topic.website,
                Header("more_partners".localized),
                Topic.appt,
                Topic.abra,
                Topic.sidnFonds
            ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "more_title".localized
    }
    
    override func didSelectItem(_ item: Any, indexPath: IndexPath) {
        guard let topic = item as? Topic else {
            return
        }
        
        if topic == .rating, let url = URL(string: topic.url) {
            UIApplication.shared.open(url, options: [:])
        } else if topic == .share, let cell = tableView.cellForRow(at: indexPath) {
            shareApp(cell)
        } else {
            openWebsite(topic.url)
        }
    }
}
