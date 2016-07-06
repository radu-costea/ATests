//
//  AppearenceCustomizer.swift
//  ATests
//
//  Created by Radu Costea on 08/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import UIKit

class OrangeNavigationController: UINavigationController {
    var observer: NSObjectProtocol? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        registerForAppearenceChanges()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        registerForAppearenceChanges()
    }
    
    override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
        registerForAppearenceChanges()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        registerForAppearenceChanges()
    }
    
    deinit {
        if let obs = observer {
            NSNotificationCenter.defaultCenter().removeObserver(obs)
            observer = nil
        }
    }
    
    func registerForAppearenceChanges() {
        observer = NSNotificationCenter.defaultCenter().addObserverForName(kThemeColor, object: nil, queue: nil) { [unowned self] (notif) in
            if let color = notif.userInfo?["color"] as? UIColor {
                self.navigationBar.barTintColor = color
            }
        }
    }
}

class AppearenceCustomizer {
    static func setupAppearence() -> Void {
        RoundedButton.appearance().cornerRadius = 5.0
        OrangeButton.appearance().backgroundColor = primaryColor
        BlueButton.appearance().backgroundColor = alternateColor
        UINavigationBar.appearanceWhenContainedInInstancesOfClasses([OrangeNavigationController.self]).barTintColor = primaryColor
    }
    
    static var allColors: [String] = {
        let intervalCount = 16
        let step = 256 / intervalCount
        
        let arr1 = (0..<intervalCount).map{ (red: 255, green: $0 * step, blue: 0) }
        let arr2 = (0..<intervalCount).map{ (red: 255 - $0 * step, green: 255, blue: 0) }
        let arr3 = (0..<intervalCount).map{ (red: 0, green: 255, blue: $0 * step) }
        let arr4 = (0..<intervalCount).map{ (red: 0, green: 255 - $0 * step, blue: 255) }
        let arr5 = (0..<intervalCount).map{ (red: $0 * step, green: 0, blue: 255) }
        let arr6 = (0..<intervalCount).map{ (red: 255, green: 0, blue: 255 - $0 * step) }
        let arr7 = (0..<intervalCount).map{ (red: $0 * step, green: $0 * step, blue: $0 * step) }
        let arr = [arr1, arr2, arr3, arr4, arr5, arr6, arr7].flatMap{ $0 }
        return arr.map{ rgbToHex($0) }
    }()
    
    static var primaryColor: UIColor {
        get {
            if let string = NSUserDefaults.standardUserDefaults().stringForKey("primary") {
                return UIColor(hex: string)!
            }
            return UIColor(hex: allColors.last!)!
        }
        set {
            NSUserDefaults.standardUserDefaults().setObject(newValue.hex, forKey: "primary")
            NSUserDefaults.standardUserDefaults().synchronize()
            NSNotificationCenter.defaultCenter().postNotificationName(kThemeColor, object: nil, userInfo: ["color" : newValue])
        }
    }
    
    static var alternateColor: UIColor {
        get {
            if let string = NSUserDefaults.standardUserDefaults().stringForKey("alternate") {
                return UIColor(hex: string)!
            }
            return UIColor(hex: allColors.first!)!
        }
        set {
            NSUserDefaults.standardUserDefaults().setObject(newValue.hex, forKey: "alternate")
            NSUserDefaults.standardUserDefaults().synchronize()
            NSNotificationCenter.defaultCenter().postNotificationName(kAlternateThemeColor, object: nil, userInfo: ["color" : newValue])
        }
    }
}