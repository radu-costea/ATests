//
//  OrangeButton.swift
//  ATests
//
//  Created by Radu Costea on 13/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

let kThemeColor: String = "ThemeColor"
let kAlternateThemeColor: String = "AlternateThemeColor"

class ThemeButton: UIButton {
    var observer: NSObjectProtocol? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        registerForAppearenceChanges()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        registerForAppearenceChanges()
    }
    
    deinit {
        if let obs = observer {
            NSNotificationCenter.defaultCenter().removeObserver(obs)
            observer = nil
        }
    }
    
    func registerForAppearenceChanges() { }
}

class RoundedButton: ThemeButton { }

class OrangeButton: ThemeButton {
    override func registerForAppearenceChanges() {
        observer = NSNotificationCenter.defaultCenter().addObserverForName(kThemeColor, object: nil, queue: nil) { [unowned self] (notif) in
            if let color = notif.userInfo?["color"] as? UIColor {
                self.backgroundColor = color
            }
        }
    }
}

class BlueButton: ThemeButton {
    override func registerForAppearenceChanges() {
        observer = NSNotificationCenter.defaultCenter().addObserverForName(kAlternateThemeColor, object: nil, queue: nil) { [unowned self] (notif) in
            if let color = notif.userInfo?["color"] as? UIColor {
                self.backgroundColor = color
            }
        }
    }
}
