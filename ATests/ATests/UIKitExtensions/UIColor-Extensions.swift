//
//  UIColor-Extensions.swift
//  ATests
//
//  Created by Radu Costea on 08/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init?(hex: String) {
        guard hex.length == 7 else {
            return nil
        }
        guard hex[hex.startIndex] == "#" else {
            return nil
        }
        let start = hex.startIndex.successor()
        let colors = (0..<3).map{ hex.substringWithRange(start.advancedBy($0 * 2)..<start.advancedBy($0 * 2 + 2)) }
        let floatValues = colors.map{ CGFloat(Int($0, radix: 16) ?? 0.0) / 255.0 }
        self.init(red: floatValues[0], green: floatValues[1], blue: floatValues[2], alpha: 1.0)
    }
}