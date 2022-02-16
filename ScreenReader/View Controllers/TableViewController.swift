//
//  TableViewController.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class TableViewController: ViewController {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set-up UITableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .primary
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        // Should be overridden to handle refresh logic
    }
    
    func loadMore() {
        // Can be overridden to implement 'infinite scrolling'
    }
}

// MARK: - UITableViewDelegate

extension TableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("cellForRowAt() must be implemented")
    }
}


// MARK: - UITableViewDelegate

extension TableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1, indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            loadMore()
        }
    }
        
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView, let label = header.textLabel {
            header.accessibilityTraits = .header
            
            label.text = tableView.dataSource?.tableView?(tableView, titleForHeaderInSection: section)
            label.font = .openSans(weight: .bold, size: 18, style: .headline)
            label.textColor = .foreground
        }
    }

    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let footer = view as? UITableViewHeaderFooterView, let label = footer.textLabel {
            label.text = tableView.dataSource?.tableView?(tableView, titleForFooterInSection: section)
            label.font = .openSans(weight: .regular, size: 18, style: .footnote)
            label.textColor = .foreground
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
