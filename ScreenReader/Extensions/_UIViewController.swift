//
//  _UIViewController.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit
import SafariServices
import StoreKit

extension UIViewController {
    
    func openWebsite(_ urlString: String, delegate: SFSafariViewControllerDelegate? = nil) {
        if let url = URL(string: urlString) {
            openWebsite(url, delegate: delegate)
        }
    }
    
    func openWebsite(_ url: URL, delegate: SFSafariViewControllerDelegate? = nil) {
        let configuration = SFSafariViewController.Configuration()
        configuration.barCollapsingEnabled = false
        configuration.entersReaderIfAvailable = false
        
        let safariViewController = SFSafariViewController(url: url, configuration: configuration)
        safariViewController.delegate = delegate
        safariViewController.preferredBarTintColor = .background
        safariViewController.preferredControlTintColor = .primary
        safariViewController.dismissButtonStyle = .done
        safariViewController.modalPresentationCapturesStatusBarAppearance = true
        safariViewController.modalPresentationStyle = .pageSheet
        safariViewController.dismissButtonStyle = .close
        
        present(safariViewController, animated: true)
    }
    
    func requestReview() {
        guard #available(iOS 14.0, *) else {
            return
        }
        
        // Only ask once per session
        if Preferences.isReviewPrompted {
            return
        }
        
        // At least 5 completed events
        let count = Gesture.completed() + Actions.completed()
        if count < 5 {
            return
        }
        
        // Request review
        guard let windowScene = self.view.window?.windowScene else {
            return
        }
        
        // Ask for review
        Preferences.isReviewPrompted = true
        Alert.Builder()
            .title("app_review".localized)
            .action("continue".localized) {
                // Request review
                SKStoreReviewController.requestReview(in: windowScene)
            }.cancelAction()
            .present(in: self)
    }
}
