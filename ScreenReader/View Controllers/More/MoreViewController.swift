//
//  MoreViewController.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class MoreViewController: TableViewController {
    
    private let items: [Any] = [
        "more_description".localized,
        Topic.rating,
        Topic.share,
        Header("more_partners".localized),
        Topic.appt,
        Topic.abra,
        Topic.sidnFonds
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        tableView.registerNib(HeaderTableViewCell.self)
        tableView.registerNib(TextTableViewCell.self)
        tableView.registerNib(TitleTableViewCell.self)
        
        tableView.reloadData()
    }
    
    @IBAction private func onShareTapped(_ sender: Any) {
        shareApp()
    }
}

// MARK: - UITableView

extension MoreViewController {
            
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        if let string = item as? String {
            let cell = tableView.cell(TextTableViewCell.self, at: indexPath)
            cell.setup(string)
            return cell
        } else if let header = item as? Header {
            let cell = tableView.cell(HeaderTableViewCell.self, at: indexPath)
            cell.setup(header.text)
            return cell
        } else if let topic = item as? Topic {
            let cell = tableView.cell(TitleTableViewCell.self, at: indexPath)
            cell.setup(topic)
            return cell
        }
        
        fatalError("Cell for object \(item) not implemented")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let topic = items[indexPath.row] as? Topic {
            if topic == .rating, let url = URL(string: topic.website) {
                UIApplication.shared.open(url, options: [:])
                return
            } else if topic == .share {
                shareApp()
            }
            
            openWebsite(topic.website)
        }
    }
}

