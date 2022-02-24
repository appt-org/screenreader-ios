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
    var lastSelectedRow: IndexPath?
    
    private(set) var items: [Any] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set-up UITableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = UITableView.automaticDimension
        
        // Register cells
        tableView.registerNib(HeaderTableViewCell.self)
        tableView.registerNib(InputTableViewCell.self)
        tableView.registerNib(ItemTableViewCell.self)
        tableView.registerNib(TextTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if lastSelectedRow != nil {
            tableView.reloadData()
        }
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .primary
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    @objc private func refresh(_ refreshControl: UIRefreshControl) {
        refreshItems()
    }
    
    func refreshItems() {
        // Should be overridden to handle refresh logic
    }
    
    func loadMoreItems() {
        // Can be overridden to implement 'infinite scrolling'
    }
    
    func didSelectItem(_ item: Any, indexPath: IndexPath) {
        // Can be overridden to implement selection
    }
    
    // MARK: - Cells
    
    func headerTableViewCell(_ header: Header, indexPath: IndexPath) -> HeaderTableViewCell {
        let cell = tableView.cell(HeaderTableViewCell.self, at: indexPath)
        cell.setup(header.text)
        return cell
    }
    
    func inputTableViewCell(_ input: Input, indexPath: IndexPath) -> InputTableViewCell {
        let cell = tableView.cell(InputTableViewCell.self, at: indexPath)
        cell.setup(input)
        return cell
    }
    
    func itemTableViewCell(_ item: Item, indexPath: IndexPath) -> ItemTableViewCell {
        let cell = tableView.cell(ItemTableViewCell.self, at: indexPath)
        cell.setup(item)
        return cell
    }
    
    func textTableViewCell(_ text: String, indexPath: IndexPath) -> TextTableViewCell {
        let cell = tableView.cell(TextTableViewCell.self, at: indexPath)
        cell.setup(text)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        let cell: UITableViewCell!
        
        if let text = item as? String {
            cell = textTableViewCell(text, indexPath: indexPath)
        } else if let input = item as? Input {
            cell = inputTableViewCell(input, indexPath: indexPath)
        } else if let item = item as? Item {
            cell = itemTableViewCell(item, indexPath: indexPath)
        } else if let header = item as? Header {
            cell = headerTableViewCell(header, indexPath: indexPath)
        
        } else {
            fatalError("Cell for object \(item) not implemented")
        }
                        
        return cell
    }
}


// MARK: - UITableViewDelegate

extension TableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1, indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            loadMoreItems()
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
        lastSelectedRow = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = items[indexPath.row]
        didSelectItem(item, indexPath: indexPath)
    }
}
