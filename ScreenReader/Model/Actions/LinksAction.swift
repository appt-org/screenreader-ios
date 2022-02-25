//
//  LinksAction.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 25/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class LinksAction: Action2 {
    
    let identifier = "links"
    
    let items: [Any] = [
        "Met de VoiceOver rotor kun je via links navigeren. Dit is handig om bijvoorbeeld telefoonnummers te vinden. Zo navigeer je via links:",
        "1. Zet de rotor op 'Links'",
        "2. Veeg met één vinger omlaag om naar de volgende link te gaan.",
        "Navigeer drie keer via links  om de training af te ronden.",
        "Eerste link: www.appt.nl",
        "Deze tekst sla je over als je navigeert via links.",
        "Tweede link: info@appt.nl",
        "Deze tekst sla je over als je navigeert via links.",
        "Derde link: 06-12345678",
        "Deze tekst sla je over als je navigeert via links.",
    ]
    
    func onFocusChanged(_ elements: [UIAccessibilityElement]) -> Bool {
        let count = elements.count
        
        guard count >= 3 else {
            return false
        }
        
        // Check if the last three elements contain the `link` accessibility trait
        if elements.dropFirst(count-3).allSatisfy({ $0.accessibilityTraits.contains(.link) }) {
            return true
        }
        
        return false
    }
}
