//
//  TabBarController.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 09/03/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        guard let viewControllers = self.viewControllers else {
            return
        }
        
        for (index, vc) in viewControllers.enumerated() {
            guard let navigationController = vc as? UINavigationController,
                  let viewController = navigationController.topViewController else {
                return
            }
            switch index {
                case 0:
                    viewController.title = "voiceover_title".localized
                    navigationController.tabBarItem.title = "voiceover_tab".localized
                case 1:
                    viewController.title = "gestures_title".localized
                    navigationController.tabBarItem.title = "gestures_tab".localized
                case 2:
                    viewController.title = "actions_title".localized
                    navigationController.tabBarItem.title = "actions_tab".localized
                case 3:
                    viewController.title = "more_title".localized
                    navigationController.tabBarItem.title = "more_tab".localized
                default:
                    break
            }
        }
    }
    
    var visibleViewController: UIViewController? {
        if let firstViewController = self.viewControllers?.first as? UINavigationController {
            return firstViewController.topViewController
        }
        return nil
    }
    
    override func accessibilityPerformEscape() -> Bool {
        visibleViewController?.accessibilityPerformEscape()
        return true
    }
    
    override func accessibilityPerformMagicTap() -> Bool {
        visibleViewController?.accessibilityPerformMagicTap()
        return true
    }
}

// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        //print("TabBarController: shouldSelect")
        return true
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //print("TabBarController: didSelect")
    }
}

