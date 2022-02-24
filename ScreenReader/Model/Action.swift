//
//  Action.swift
//  Appt
//
//  Created by Jan Jaap de Groot on 02/09/2020.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import UIKit

enum Action: String, Learning {

    // Navigation
    case headings
    case links
    
    // Modify
    case selection
    case copy
    case paste
    
    /** Identifier */
    var id: String {
        return rawValue
    }
    
    /** Title */
    var title: String {
        return NSLocalizedString("action_"+rawValue+"_title", comment: "")
    }
    
    /** View */
    var view: VoiceOverView {
    switch self {
        case .headings:
            return VoiceOverHeadingsView.create(self)
        case .links:
            return VoiceOverLinksView.create(self)
        
        case .selection:
            return VoiceOverSelectionView.create(self)
        case .copy:
            return VoiceOverCopyView.create(self)
        case .paste:
            return VoiceOverPasteView.create(self)
        }
    }
    
    /** Items */
    var items: [Any] {
        return [
            "Met de VoiceOver rotor kun je via koppen navigeren. Dit is handig bij lange pagina's of websites. Zo navigeer je via koppen:",
            "1. Zet de rotor op 'Kopregels'.",
            "2. Veeg met één vinger omlaag om naar de volgende kop te gaan.",
            "Navigeer drie keer via kopregels om de training af te ronden.",
            Header("Kop 1"),
            "Als je via kopregels navigeert sla je deze tekst over.",
            Header("Kop 2"),
            "Als je via kopregels navigeert sla je deze tekst over.",
            Header("Kop 3"),
            "Als je via kopregels navigeert sla je deze tekst over.",
            Input(placeholder: "XXX", text: "XXX")
        ]
    }
    
    /** On focus changed */
    func onFocusChanged(_ views: [UIView]) -> Bool {
        let count = views.count

        guard count >= 3 else {
            return false
        }
        
        // Check if the last three views are HeaderTableViewCell
        if views.dropFirst(count-3).allSatisfy({
            $0 is HeaderTableViewCell
        }) {
            return true
        }
        
        return false
    }
            
    /** Completed? */
    var completed: Bool {
       set {
           UserDefaults.standard.set(newValue, forKey: id)
       }
       get {
           return UserDefaults.standard.bool(forKey: id)
       }
    }
}
