//
//  SelectionAction.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 25/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class SelectionAction: Action2 {
    
    let identifier = "selection"
    
    let items: [Any] = [
        "De makkelijkste manier om tekst te selecteren is via de 'Tekstselectie' optie. Deze optie moet je zelf toevoegen aan de rotor.",
        Header("Tekstselectie toevoegen aan rotor"),
        "1. Open de 'Instellingen' app",
        "2. Selecteer 'Toegankelijkheid'",
        "3. Selecteer 'VoiceOver'",
        "4. Selecteer 'Rotor'",
        "5. Zet 'Tekstselectie' aan",
        Header("Tekstselectie gebruiken"),
        "1. Selecteer het veld waar je tekst wilt selecteren.",
        "2. Dubbeltik om te starten met bewerken.",
        "3. Zet de rotor op 'Tekstselectie'",
        "4. Veeg met één vinger omlaag om de gewenste optie te selecteren",
        "5. Veeg naar rechts om het volgende onderdeel te selecteren.",
        "6. Veeg naar links om het vorige onderdeel te selecteren.",
        "Selecteer tekst in het onderstaande tekstveld om de training af te ronden.",
        Input(placeholder: "Vul tekst in om te selecteren", text: "Selecteer deze tekst")
    ]
    
    func onTextSelected(_ textField: TextField, range: UITextRange?) -> Bool {
        guard let range = range else {
            return false
        }
        
        return textField.offset(from: range.start, to: range.end) > 0
    }
}
