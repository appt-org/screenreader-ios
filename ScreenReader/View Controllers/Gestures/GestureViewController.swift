//
//  GestureViewController.swift
//  Appt
//
//  Created by Jan Jaap de Groot on 24/06/2020.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import UIKit
import AVKit

class GestureViewController: ViewController {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var feedbackLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var explanationItem: UIBarButtonItem!
    
    var gesture: Gesture!
    var gestures: [Gesture]?
    var instructions: Bool = true
    
    private var errorLimit = 10
    private var errorCount = 0
    
    private var finished = false
    private var incorrect = false

    private lazy var gestureView: GestureView = {
        let gestureView = gesture.view
        gestureView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gestureView)
        
        if let view = self.view {
            NSLayoutConstraint(item: gestureView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
            NSLayoutConstraint(item: gestureView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0).isActive = true
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: gestureView, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
            NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: gestureView, attribute: .trailing, multiplier: 1.0, constant: 0.0).isActive = true
        }
        
        view.bringSubviewToFront(gestureView)
        return gestureView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = nil
        
        titleLabel.accessibilityTraits = .header
        titleLabel.font = .openSans(weight: .bold, size: 20, maxSize: 30)
        titleLabel.text = gesture.title
        
        descriptionLabel.font = .openSans(weight: .regular, size: 18, maxSize: 27)
        descriptionLabel.text = gesture.description
        
        feedbackLabel.font = .openSans(weight: .regular, size: 16, maxSize: 24)
        feedbackLabel.isHidden = true
        
        imageView.image = gesture.image
        imageHeightConstraint.constant = view.frame.height / 3
        view.sendSubviewToBack(imageView)
        
        explanationItem.title = "explanation".localized
        
        if !instructions {
            gestureView.accessibilityLabel = gesture.title
            descriptionLabel.isHidden = true
            imageView.isHidden = true
            explanationItem.isEnabled = false
            navigationItem.rightBarButtonItem = nil
        }
        
        gestureView.delegate = self
        view.accessibilityElements = [gestureView]
        
        UIAccessibility.post(notification: .screenChanged, argument: gestureView)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        imageHeightConstraint.constant = size.height / 3
        gestureView.setNeedsDisplay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        NotificationCenter.default.removeObserver(self)
        super.viewWillDisappear(animated)
    }
    
    @IBAction private func onExplanationTapped(_ sender: Any) {
        Alert.Builder()
            .title(gesture.title)
            .message(gesture.explanation)
            .okAction()
            .present(in: self)
    }
    
    private func next() {
        guard var viewControllers = self.navigationController?.viewControllers, var gestures = self.gestures else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        gestures.removeFirst()
        
        viewControllers[viewControllers.count-1] = UIStoryboard.gestures(gestures, instructions: self.instructions)
        self.navigationController?.setViewControllers(viewControllers, animated: true)
    }
    
    private func finish() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - GestureViewDelegate

extension GestureViewController: GestureViewDelegate {
    
    func correct(_ gesture: Gesture) {
        if finished { return }
        finished = true
        
        self.gesture.completed = true
        //Events.log(.gestureCompleted, identifier: gesture.id, value: errorCount)
        
        // Check if single gesture
        guard let gestures = self.gestures else {
            Alert.toast("gesture_correct".localized, duration: 2.5, viewController: self) {
                self.finish()
            }
            return
        }
        
        // Check if all gestures have been completed
        guard gestures.count > 1 else {
            Alert.Builder()
                .title("gesture_completed".localized)
                .action("finish".localized) {
                    self.finish()
                }.present(in: self)
            return
        }
        
        // Continue to next gesture
        Alert.toast("gesture_correct".localized, duration: 2.5, viewController: self) {
            self.next()
        }
    }
    
    func incorrect(_ gesture: Gesture, feedback: String) {
        print("Incorrect: \(feedback)")
        
        if finished { return }
        if incorrect { return }
        
        incorrect = true
        errorCount += 1
        
        let feedback = instructions ? feedback : "gesture_feedback".localized
        
        // Announce & display feedback
        UIAccessibility.post(notification: .announcement, argument: feedback)
        
        if feedbackLabel.isHidden {
            feedbackLabel.text = nil
            feedbackLabel.isHidden = false
        }
        UIView.transition(with: self.feedbackLabel, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.feedbackLabel.alpha = 0
        }, completion: { _ in
            UIView.transition(with: self.feedbackLabel, duration: 0.2, options: .transitionCrossDissolve, animations: {
                if self.finished { return }
                self.incorrect = false
                
                self.feedbackLabel.text = feedback
                self.feedbackLabel.alpha = 1.0
            })
        })
        
        // Provide an option to stop after each five attempts
        if errorCount >= errorLimit {
            Alert.Builder()
                .title("gesture_incorrect".localized(errorCount))
                .action("stop".localized, style: .destructive) {
                    self.finish()
                }
                .action("skip".localized, style: .default) {
                    self.next()
                }
                .action("continue".localized, style: .cancel) {
                    self.errorLimit = self.errorLimit * 2
                    UIAccessibility.post(notification: .screenChanged, argument: self.gestureView)
                }.present(in: self)
        }
    }
}
