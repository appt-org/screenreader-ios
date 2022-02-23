//
//  ActionsViewController.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class ActionsViewController: TableViewController {
 
    override var items: [Any] {
        get {
            return [
                "actions_description".localized,
                Header("actions_navigate".localized),
                Action.headings,
                Action.links,
                Header("actions_edit".localized),
                Action.selection,
                Action.copy,
                Action.paste
            ]
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = lastSelectedRow {
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    override func didSelectItem(_ item: Any, indexPath: IndexPath) {
        guard let action = item as? Action else {
            return
        }
        
        guard UIAccessibility.isVoiceOverRunning else {
            Alert.Builder()
                .title("action_voiceover_disabled".localized)
                .message("action_voiceover_enable".localized)
                .okAction()
                .present(in: self)
            return
        }
        
        let vc = UIStoryboard.action2(action)
        navigationController?.pushViewController(vc, animated: true)
    }
}
