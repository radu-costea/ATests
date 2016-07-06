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
        guard hex.length == 7 && hex[hex.startIndex] == "#" else {
            return nil
        }
        
        let hexString = hex.substringFromIndex(hex.startIndex.successor())
        let hexValue = Int(hexString, radix: 16)!
        
        let red = (hexValue & (255 << 16)) >> 16
        let green = (hexValue & (255 << 8)) >> 8
        let blue = hexValue & 255
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    var hex: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return String(format: "#%02X%02X%02X", arguments: [Int(red * 255), Int(green * 255), Int(blue * 255)])
    }
}