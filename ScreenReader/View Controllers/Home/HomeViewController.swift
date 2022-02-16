//
//  HomeViewController.swift
//  ScreenReader
//
//  Created by Jan Jaap de Groot on 16/02/2022.
//  Copyright © 2022 Stichting Appt & Abra B.V. All rights reserved.
//

import UIKit

class HomeViewController: TextViewController {
    
    override var items: [Any] {
        get {
            return [
                "This ScreenReader app helps you to learn VoiceOver.",
                Header("What is VoiceOver?"),
                "VoiceOver is an accessibility feature which gives you audible screen descriptions. By using gestures you can navigate between elements on the screen. Each element is announced as it is selected. This allows you to control your device even if you can't see the screen.",
                Header("Learning VoiceOver"),
                "VoiceOver is a crucial aid for visually impaired people to use their device. This app helps you to learn all gestures and common actions. If you are dependent on VoiceOver, use this app to improve your skills. If you are a professional, use the learnings to improve the accessibility of your apps.",
                Header("Learning gestures"),
                "Open the Gestures tab to learn gestures. There are three simple gestures to control your device.",
                "1. Swipe left to go to the previous item.",
                "2. Swipe right to go to the next item.",
                "3. Double tap to activate the selected item.",
                Header("Learning actions"),
                "Once you have mastered the gestures, open the Actions tab to learn actions. You can learn how to navigate more effectively and how to edit text.",
                Header("Turning on VoiceOver"),
                "If you are ready to turn on VoiceOver, ask Siri to \"Turn VoiceOver on\". Or open the Settings app, select Accessibility, select VoiceOver and toggle the switch on.",
                Header("Turning off VoiceOver"),
                "You can turn off VoiceOver by asking Siri to \"Turn VoiceOver off\". Or open the Settings app, select Accessibility, select VoiceOver and toggle the switch off. Remember that you need to swipe to navigate and double tap to activate.",
                Header("VoiceOver shortcut"),
                "It's possible add a shortcut to toggle VoiceOver on or off. Open the Settings app, select Accessibility, scroll down and select Accessibility Shortcut and finally select VoiceOver in the list. Triple tap the home button or side button to toggle VoiceOver on or off."
            ]
        }
    }
}
