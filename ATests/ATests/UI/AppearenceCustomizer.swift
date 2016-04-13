//
//  AppearenceCustomizer.swift
//  ATests
//
//  Created by Radu Costea on 08/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import UIKit

class AppearenceCustomizer {
    static func setupDefaultAppearence() -> Void {
        RoundedButton.appearance().cornerRadius = 5.0
        OrangeButton.appearance().backgroundColor = UIColor(hex: "#D44400")
        BlueButton.appearance().backgroundColor = UIColor(hex: "#429DC0")
        UINavigationBar.appearance().backgroundColor = UIColor(hex: "#333333")
    }
}