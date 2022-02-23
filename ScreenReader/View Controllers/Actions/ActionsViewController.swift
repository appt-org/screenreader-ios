//
//  ActionsViewController.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class ActionsViewController: TableViewController {
 
    private let items: [Any] = [
        "actions_description".localized,
        Header("actions_navigate".localized),
        Action.headings,
        Action.links,
        Header("actions_edit".localized),
        Action.selection,
        Action.copy,
        Action.paste
    ]
        
    private var lastSelectedRow: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set-up UITableView
        tableView.registerNib(HeaderTableViewCell.self)
        tableView.registerNib(TextTableViewCell.self)
        tableView.registerNib(TitleTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = lastSelectedRow {
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ActionViewController {
            if let action = sender as? Action {
                vc.action = action
            }
        }
    }
}

// MARK: - UITableView

extension ActionsViewController {
        
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
        } else if let action = item as? Action {
            let cell = tableView.cell(TitleTableViewCell.self, at: indexPath)
            cell.setup(action)
            return cell
        }
        
        fatalError("Cell for object \(item) not implemented")
    }
}

// MARK: - UITableViewDelegate

extension ActionsViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastSelectedRow = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let action = items[indexPath.row] as? Action else {
            return
        }
        
        let vc = UIStoryboard.action(action)
        navigationController?.pushViewController(vc, animated: true)
    }
}
