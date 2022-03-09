//
//  PasteAction.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 25/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import Foundation

class PasteAction: Action {
    
    let identifier = "paste"
    
    let items: [Any] = [
        "Via de VoiceOver rotor kun je tekst plakken.",
        "1. Selecteer het veld waar je in wilt plakken.",
        "2. Dubbeltik om te starten met invoeren.",
        "3. Zet de rotor op 'Wijzigen'.",
        "4. Veeg met één vinger omlaag tot 'Plakken' is geselecteerd.",
        "5. Dubbeltik om te plakken.",
        "Plak tekst in het onderstaande tekstveld om de training af te ronden.",
        Input(placeholder: "Plak hier vanuit je klembord")
    ]
        
    func onTextPasted(_ textField: TextField, text: String?) -> Bool {
        guard let text = text else {
            return false
        }
        return text.count > 1
    }
}
