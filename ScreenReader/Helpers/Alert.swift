//
//  Alert.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 17/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit
import Accessibility

class Alert {

    public static func toast(_ message: String, duration: Double, viewController: UIViewController, callback: (() -> Void)? = nil) {
        let alert = Builder()
            .message(message)
            .backgroundColor(.clear)
            .alpha(0.5)
            .cornerRadius(15)
            .build()

        viewController.present(alert, animated: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            alert.dismiss(animated: true)
            callback?()
        }
    }
    
    public static func error(_ message: String, viewController: UIViewController, callback: (() -> Void)? = nil) {
        let alert = Builder()
            .title("error".localized)
            .message(message)
            .okAction(callback: callback)
            .build()
        
        viewController.present(alert, animated: true)
    }
    
    class Builder {
        
        private var title: String?
        private var message: String?
        private var preferredStyle: UIAlertController.Style = .alert
        private var tintColor: UIColor = .foreground
        private var backgroundColor: UIColor = .clear
        private var alpha: CGFloat = 1.0
        private var cornerRadius:CGFloat = 0.0
        private var sourceView: UIView?
        private var sourceRect: CGRect?
        private var actions: [UIAlertAction] = [UIAlertAction]()
        
        init() {
            // Empty
        }
        
        func title(_ title: String) -> Builder {
            self.title = title
            return self
        }
        
        func message(_ message: String) -> Builder {
            self.message = message
            return self
        }
        
        func preferredStyle(_ style: UIAlertController.Style) -> Builder {
            self.preferredStyle = style
            return self
        }
        
        func tintColor(_ tintColor: UIColor) -> Builder {
            self.tintColor = tintColor
            return self
        }
        
        func backgroundColor(_ backgroundColor: UIColor) -> Builder {
            self.backgroundColor = backgroundColor
            return self
        }
        
        func alpha(_ alpha: CGFloat) -> Builder {
            self.alpha = alpha
            return self
        }
        
        func cornerRadius(_ cornerRadius: CGFloat) -> Builder {
            self.cornerRadius = cornerRadius
            return self
        }
                
        func sourceView(_ sourceView: UIView) -> Builder {
            self.sourceView = sourceView
            return self
        }
        
        func sourceRect(_ sourceRect: CGRect) -> Builder {
            self.sourceRect = sourceRect
            return self
        }
        
        
        func okAction(_ title: String = "ok".localized, callback: (() -> Void)? = nil) -> Builder {
            return action(title, style: .cancel, callback: callback)
        }
        
        func cancelAction(_ title: String = "cancel".localized, callback: (() -> Void)? = nil) -> Builder {
            return action(title, style: .cancel, callback: callback)
        }
        
        func destructiveAction(_ title: String = "delete".localized, callback: (() -> Void)? = nil) -> Builder {
            return action(title, style: .destructive, callback: callback)
        }
        
        func action(_ title: String, style: UIAlertAction.Style = .default, callback: (() -> Void)? = nil) -> Builder {
            let action = UIAlertAction(title: title, style: style) { (action) in
                callback?()
            }
            actions.append(action)
            return self
        }

        func build() -> UIAlertController {
            let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
            
            // Larger title
            if let title = title {
                let attributedTitle = NSAttributedString(string: title, attributes: [
                    .font: UIFont.openSans(weight: .bold, size: 20, style: .title1),
                    .foregroundColor : UIColor.foreground
                ])
                
                alert.setValue(attributedTitle, forKey: "attributedTitle")
            }
            
            // Larger message
            if let message = message {
                let attributedMessage = NSMutableAttributedString(string: message, attributes: [
                    .font: UIFont.openSans(weight: .regular, size: 18, style: .body),
                    .foregroundColor : UIColor.foreground
                ])
                
                if title != nil {
                    attributedMessage.mutableString.setString("\n" + message)
                }
                
                alert.setValue(attributedMessage, forKey: "attributedMessage")
            }
            
            // Styles
            alert.view.tintColor = tintColor
            alert.view.backgroundColor = backgroundColor
            alert.view.alpha = alpha
            alert.view.layer.cornerRadius = cornerRadius
            
            // Popover
            if let sourceView = sourceView {
                alert.popoverPresentationController?.sourceView = sourceView
            }
            if let sourceRect = self.sourceRect {
                alert.popoverPresentationController?.sourceRect = sourceRect
            }
            
            // Actions
            actions.forEach { (action) in
                alert.addAction(action)
            }
            
            return alert
        }
        
        func present(in viewController: UIViewController, animated: Bool = true, completion:(() -> Void)? = nil) {
            viewController.present(build(), animated: animated, completion: completion)
        }
    }
}
