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
        
        let backButton = UIBarButtonItem(title: "back".localized, style: .plain, target: nil, action: nil)
        backButton.accessibilityLabel = "back".localized
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
    
    // View will appear: register notifications
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
        registerStateNotifications()
        registerAccessibilityNotifications()
    }
        
    // View will disappear: deregister notifications
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deregisterKeyboardNotifications()
        deregisterStateNotifications()
        deregisterAccessibilityNotifications()
    }
    
    func shareApp() {
        let shareViewController = UIActivityViewController(activityItems: [Topic.share.website], applicationActivities: [])
        present(shareViewController, animated: true)
    }
}

// MARK: - Keyboard notifications

extension ViewController {
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func deregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let bottomInset = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            let height = keyboardFrame.cgRectValue.height - bottomInset
            keyboardWillShow(height: height)
        }
    }
    
    @objc func keyboardWillShow(height: CGFloat) {
         print("keyboardWillShow, height = \(height)")
    }
        
    @objc func keyboardWillHide() {
        print("keyboardWillHide")
    }
}


// MARK: - State notifications

extension ViewController {
    
    // State: register notifications
    private func registerStateNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(onStateForeground(_:)), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onStateActive(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onStateBackground(_:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onStateResign(_:)), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onStateTerminate(_:)), name: UIApplication.willTerminateNotification, object: nil)
    }
    
    // State: deregister state notifications
    private func deregisterStateNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.willTerminateNotification, object: nil)
    }
    
    // State: entered foreground
    @objc private func onStateForeground(_ notification: Notification) {
        onStateForeground()
    }
    
    @objc func onStateForeground() {
        // Can be overridden
    }
    
    // State: became active
    @objc private func onStateActive(_ notification: Notification) {
        onStateActive()
    }
    
    @objc func onStateActive() {
        // Can be overridden
    }
    
    // State: entered background
    @objc private func onStateBackground(_ notification: Notification) {
        onStateBackground()
    }
    
    @objc func onStateBackground() {
        // Can be overridden
    }
    
    // State: will resign
    @objc private func onStateResign(_ notification: Notification) {
        onStateResign()
    }
    
    @objc func onStateResign() {
        // Can be overridden
    }
    
    // State: will terminate
    @objc private func onStateTerminate(_ notification: Notification) {
        onStateTerminate()
    }
    
    @objc func onStateTerminate() {
        // Can be overridden
    }
}


// MARK: - Accessibility notifications

extension ViewController {
    
    // Accessibility: register notifications
    private func registerAccessibilityNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(announcementFinished(_:)),name: UIAccessibility.announcementDidFinishNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector:#selector(contentSizeCategoryDidChange(notification:)), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
    
    // Accessibility: deregister notifications
    private func deregisterAccessibilityNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIAccessibility.announcementDidFinishNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
    
    @objc private func announcementFinished(_ notification: Notification) {
        guard let info = notification.userInfo else { return }
        guard let announcement = info[UIAccessibility.announcementStringValueUserInfoKey] as? String else { return }
        guard let success = info[UIAccessibility.announcementWasSuccessfulUserInfoKey] as? Bool else { return }
        
        announcementFinished(success: success, announcement: announcement)
    }

    @objc func contentSizeCategoryDidChange(notification: Notification) {
        // Can be overridden
    }
    
    
    @objc func announcementFinished(success: Bool, announcement: String) {
        // Can be overridden
    }
}

// MARK: - Alerts

extension ViewController {
    
    func showError(_ error: Error, callback: (() -> Void)? = nil) {
        showError(error.localizedDescription, callback: callback)
    }
    
    func showError(_ error: String, callback: (() -> Void)? = nil) {
        Alert.error(error, viewController: self, callback: callback)
    }
}
