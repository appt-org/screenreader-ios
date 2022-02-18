//
//  ScrollViewController.swift
//  Appt
//
//  Created by Jan Jaap de Groot on 22/09/2020.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import Foundation
import UIKit
import AVKit

class ScrollViewController: ViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    
    func getView() -> UIView {
        fatalError("getView() must be implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let view = getView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(view)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            view.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        UIAccessibility.post(notification: .layoutChanged, argument: view)
    }
}
