//
//  AppDelegate.swift
//  screenreader
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        application.accessibilityLanguage = "en-US"
        
        // States
        let states: [UIControl.State] = [.disabled, .focused, .highlighted, .normal, .selected]
        
        // UINavigationBar
        UINavigationBar.appearance().isOpaque = false
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .background
        UINavigationBar.appearance().tintColor = .foreground
        UINavigationBar.appearance().titleTextAttributes = [
            .font: UIFont.openSans(weight: .bold, size: 20, scaled: false),
            .foregroundColor: UIColor.foreground
        ]
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font: UIFont.openSans(weight: .bold, size: 40, scaled: false),
            .foregroundColor: UIColor.foreground
        ]
        
        // UIBarButtonItem
        UIBarButtonItem.appearance().tintColor = .foreground
        states.forEach { (state) in
            UIBarButtonItem.appearance().setTitleTextAttributes([
                .font: UIFont.openSans(weight: .semibold, size: 16, scaled: false)
            ], for: state)
        }
        
        // UITabBar
        UITabBar.appearance().isOpaque = true
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().barTintColor = .background
        UITabBar.appearance().tintColor = .primary
        UITabBar.appearance().unselectedItemTintColor = .disabled
        
        // UITabBarItem
        states.forEach { (state) in
            UITabBarItem.appearance().setTitleTextAttributes([
                .font: UIFont.openSans(weight: .semibold, size: 14, scaled: false)
            ], for: state)
        }
        
        // UISegmentedControl
        UISegmentedControl.appearance().backgroundColor = .background
        UISegmentedControl.appearance().tintColor = .primary
        states.forEach { (state) in
            UISegmentedControl.appearance().setTitleTextAttributes([
                .font: UIFont.openSans(weight: .regular, size: 18, scaled: false)
            ], for: state)
        }
        UISegmentedControl.appearance().setTitleTextAttributes([
            .font: UIFont.openSans(weight: .bold, size: 18, scaled: false),
            .foregroundColor: UIColor.white
        ], for: .selected)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

