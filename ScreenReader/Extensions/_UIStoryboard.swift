//
//  _UIStoryboard.swift
//  Appt
//
//  Created by Jan Jaap de Groot on 29/05/2020.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    enum Name: String{
        case main = "Main"
    }
    
    private static func viewController<T: UIViewController>(_ storyboard: UIStoryboard.Name, identifier : T.Type? = nil) -> T {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        if let identifier = identifier {
            return storyboard.instantiateViewController(withIdentifier: String(describing: identifier)) as! T
        } else {
            return storyboard.instantiateInitialViewController() as! T
        }
    }
    
    static func gestures() -> GesturesViewController {
        return viewController(.main, identifier: GesturesViewController.self)
    }
    
    static func gesture(_ gesture: Gesture) -> GestureViewController {
        let vc = viewController(.main, identifier: GestureViewController.self)
        vc.gesture = gesture
        return vc
    }
    
    static func gestures(_ gestures: [Gesture], instructions: Bool = true) -> GestureViewController {
        let vc = viewController(.main, identifier: GestureViewController.self)
        vc.gesture = gestures[0]
        vc.gestures = gestures
        vc.instructions = instructions
        return vc
    }
    
    static func actions() -> ActionsViewController {
        return viewController(.main, identifier: ActionsViewController.self)
    }
    
    static func action2(_ action: Action) -> ActionViewController {
        let vc = viewController(.main, identifier: ActionViewController.self)
        vc.action = action
        return vc
    }
}
