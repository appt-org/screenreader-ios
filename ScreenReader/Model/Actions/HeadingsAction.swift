//
//  HeadingsAction.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 25/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class HeadingsAction: Action2 {
    
    let identifier = "headings"
    
    let items: [Any] = [
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
    
}
