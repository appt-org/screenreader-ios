//
//  TextTableViewController.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 23/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class TextTableViewController: TableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        tableView.reloadData()
    }
  
    override func headerTableViewCell(_ header: Header, indexPath: IndexPath) -> HeaderTableViewCell {
        let cell = super.headerTableViewCell(header, indexPath: indexPath)
        cell.constraint(top: 16, bottom: 0)        
        return cell
    }
    
    override func textTableViewCell(_ text: String, indexPath: IndexPath) -> TextTableViewCell {
        let cell = super.textTableViewCell(text, indexPath: indexPath)
        
        if tableView.firstIndexPath == indexPath {
            cell.constraint(top: 16, bottom: 0)
        } else if tableView.lastIndexPath == indexPath {
            cell.constraint(top: 0, bottom: 16)
        } else {
            cell.constraint(top: 0, bottom: 0)
        }
        
        return cell
    }
    
}
