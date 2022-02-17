//
//  _DispatchQueue.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var loadingIndicator: UIActivityIndicatorView?
    var isLoading: Bool = false {
        didSet {
            let loading = isLoading
            foreground {
                if loading {
                    guard self.loadingIndicator == nil else {
                        return
                    }
                    
                    let message = NSAttributedString(
                        string: "loading".localized,
                        attributes: [.accessibilitySpeechQueueAnnouncement: true]
                    )
                    UIAccessibility.post(notification: .announcement, argument: message)

                    let indicator = UIActivityIndicatorView()
                    if #available(iOS 13.0, *) {
                        indicator.style = .large
                    } else {
                        indicator.style = .whiteLarge
                    }

                    indicator.accessibilityTraits = [.image, .staticText]
                    indicator.accessibilityLabel = "loading".localized

                    indicator.backgroundColor = .background
                    indicator.color = .primary
                    indicator.tintColor = .primary
                    indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
                    indicator.center = self.view.center
                    indicator.hidesWhenStopped = false
                    indicator.startAnimating()
                    indicator.translatesAutoresizingMaskIntoConstraints = false

                    self.view.addSubview(indicator)

                    indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                    indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
                    indicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
                    indicator.widthAnchor.constraint(equalToConstant: 40).isActive = true

                    self.view.bringSubviewToFront(indicator)

                    self.loadingIndicator = indicator
                } else {
                    self.loadingIndicator?.removeFromSuperview()
                    self.loadingIndicator = nil
                }
            }
        }
    }
//
//    private(set) var hidesBottomBar = true
//    open override var hidesBottomBarWhenPushed: Bool {
//        get {
//            return hidesTabBar
//        }
//        set {
//            super.hidesBottomBarWhenPushed = newValue
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UINavigationBar style
        navigationController?.navigationBar.isOpaque = true
        navigationController?.navigationBar.isTranslucent = false
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backButton.accessibilityLabel = "Back"
        navigationItem.backBarButtonItem = backButton
        
        if #available(iOS 13.0, *) {
            let button = UIBarButtonItemAppearance()
            button.disabled.titleTextAttributes = UIBarButtonItem.appearance().titleTextAttributes(for: .disabled) ?? [:]
            button.focused.titleTextAttributes = UIBarButtonItem.appearance().titleTextAttributes(for: .focused) ?? [:]
            button.highlighted.titleTextAttributes = UIBarButtonItem.appearance().titleTextAttributes(for: .highlighted) ?? [:]
            button.normal.titleTextAttributes = UIBarButtonItem.appearance().titleTextAttributes(for: .normal) ?? [:]

            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .background
            appearance.titleTextAttributes = UINavigationBar.appearance().titleTextAttributes ?? [:]
            appearance.largeTitleTextAttributes = UINavigationBar.appearance().largeTitleTextAttributes ?? [:]
            appearance.buttonAppearance = button
            appearance.doneButtonAppearance = button
            appearance.setBackIndicatorImage(
                UINavigationBar.appearance().backIndicatorImage,
                transitionMaskImage: UINavigationBar.appearance().backIndicatorTransitionMaskImage
            )

            if let navigationBar = navigationController?.navigationBar {
                navigationBar.compactAppearance = appearance
                navigationBar.scrollEdgeAppearance = appearance
                navigationBar.standardAppearance = appearance
            }
        }

        // UITabBar style
        tabBarController?.tabBar.isOpaque = true
        tabBarController?.tabBar.isTranslucent = false
        
        if #available(iOS 15.0, *) {
            let item = UITabBarItemAppearance()
            item.disabled.titleTextAttributes = UITabBarItem.appearance().titleTextAttributes(for: .disabled) ?? [:]
            item.focused.titleTextAttributes = UITabBarItem.appearance().titleTextAttributes(for: .focused) ?? [:]
            item.normal.titleTextAttributes = UITabBarItem.appearance().titleTextAttributes(for: .normal) ?? [:]
            item.selected.titleTextAttributes = UITabBarItem.appearance().titleTextAttributes(for: .selected) ?? [:]

            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .background
            appearance.compactInlineLayoutAppearance = item
            appearance.inlineLayoutAppearance = item
            appearance.stackedLayoutAppearance = item

            if let tabBar = tabBarController?.tabBar {
                tabBar.scrollEdgeAppearance = appearance
                tabBar.standardAppearance = appearance
            }
        }
    }
}
