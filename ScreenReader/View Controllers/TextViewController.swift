//
//  TextViewController.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class TextViewController: TableViewController {
    
    private(set) var items: [Any] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(HeaderTableViewCell.self)
        tableView.registerNib(TextTableViewCell.self)
        
        tableView.separatorStyle = .none
        tableView.reloadData()
    }
}

// MARK: - UITableView

extension TextViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        if let header = item as? Header {
            let cell = tableView.cell(HeaderTableViewCell.self, at: indexPath)
            cell.setup(header.text, top: 16, bottom: 0)
            return cell
        } else if let text = item as? String {
            let cell = tableView.cell(TextTableViewCell.self, at: indexPath)
            if tableView.firstIndexPath == indexPath {
                cell.setup(text, top: 16, bottom: 0)
            } else if tableView.lastIndexPath == indexPath {
                cell.setup(text, top: 0, bottom: 16)
            } else {
                cell.setup(text, top: 0, bottom: 0)
            }
            return cell
        }
        
        fatalError("Missing cell for: \(item)")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
