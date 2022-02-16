//
//  _DispatchQueue.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import Foundation

func delay(_ delay: Double, closure: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}

func background(closure: @escaping () -> ()) {
    DispatchQueue.global(qos: .background).async {
        closure()
    }
}

func foreground(closure: @escaping () -> ()) {
    DispatchQueue.main.async {
        closure()
    }
}
