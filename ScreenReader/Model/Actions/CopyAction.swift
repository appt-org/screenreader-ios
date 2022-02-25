//
//  CopyAction.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 25/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class CopyAction: Action2 {
    
    let identifier = "copy"
    
    let items: [Any] = [
        "Via de VoiceOver rotor kun je tekst kopiëren.",
        "1. Selecteer het veld waar je tekst uit wilt kopiëren.",
        "2. Dubbeltik om te starten met bewerken.",
        "3. Zet de rotor op 'Tekstselectie'.",
        "4. Veeg omlaag tot de optie 'Selecteer alles'.",
        "5. Veeg naar rechts om alles te selecteren.",
        "6. Zet de rotor op 'Wijzigen'.",
        "7. Veeg omlaag tot de optie 'Kopiëren'.",
        "8. Dubbeltik om de geselecteerde tekst te kopiëren.",
        "Kopieer tekst uit het onderstaande invoerveld om de training af te ronden.",
        Input(placeholder: "Vul tekst in om te kopiëren", text: "Kopieer deze tekst")
    ]
    
    func onPasteboardChanged(_ content: String?) -> Bool {
        guard let content = content,
              let input = items.last as? Input else {
            return false
        }
        return input.text.contains(content)
    }
}
