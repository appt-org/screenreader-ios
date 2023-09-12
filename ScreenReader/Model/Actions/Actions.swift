//
//  Actions.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 31/08/2023.
//  Copyright © 2023 Stichting Appt & Abra B.V. All rights reserved.
//

import Foundation

class Actions {
    
    static var all: [Action] {
        return [
            HeadingsAction(),
            LinksAction(),
            SelectAction(),
            CopyAction(),
            PasteAction(),
        ]
    }
    
    static func completed() -> Int {
        return all.filter { element in
            return element.completed
        }.count
    }
}
