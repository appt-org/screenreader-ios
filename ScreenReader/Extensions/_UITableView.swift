//
//  _UITableView.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

extension UITableView {
    
    // MARK: - Cells
   
    func registerNib(_ cellClass: UITableViewCell.Type) {
        let nib = UINib(nibName: String(describing: cellClass), bundle: nil)
        register(nib, forCellReuseIdentifier: cellClass.identifier)
    }
    
    func registerNib(_ headerFooterClass: UITableViewHeaderFooterView.Type) {
        let nib = UINib(nibName: String(describing: headerFooterClass), bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: headerFooterClass.identifier)
    }
    
    func cell<T: UITableViewCell>(_ type: T.Type, at indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as! T
    }
    
    func cell<T: UITableViewHeaderFooterView>(_ type: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: type.identifier) as! T
    }
    
    // MARK: - IndexPath
    
    var firstIndexPath: IndexPath? {
        let indexPath = IndexPath(row: 0, section: 0)
        if hasRowAtIndexPath(indexPath: indexPath) {
            return indexPath
        }
        return nil
    }
    
    var lastIndexPath: IndexPath? {
        let indexPath = IndexPath(
            row: numberOfRows(inSection: numberOfSections - 1) - 1,
            section: numberOfSections - 1
        )
        if hasRowAtIndexPath(indexPath: indexPath) {
            return indexPath
        }
        return nil
    }
    
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections &&
               indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
    
    
    // MARK: - Scrolling
    
    func scrollToBottom(animated: Bool = true) {
        guard let indexPath = lastIndexPath else {
            return
        }
        DispatchQueue.main.async {
            self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
        }
    }

    func scrollToTop(animated: Bool = true) {
        guard let indexPath = firstIndexPath else {
            return
        }
        DispatchQueue.main.async {
            self.scrollToRow(at: indexPath, at: .top, animated: animated)
        }
    }
}
