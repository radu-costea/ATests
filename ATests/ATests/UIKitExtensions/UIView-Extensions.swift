//
//  UIView-Extensions.swift
//  ATests
//
//  Created by Radu Costea on 07/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import UIKit
import Parse
extension UIView {
    @IBInspectable dynamic var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(CGColor: color)
            }
            return nil
        }
        set { layer.borderColor = newValue?.CGColor }
    }
    
    @IBInspectable dynamic var borderWidth: Float {
        set{ layer.borderWidth = CGFloat(newValue ?? 0.0) }
        get{ return Float(layer.borderWidth) }
    }
    
    @IBInspectable dynamic var cornerRadius: Float {
        set{ layer.cornerRadius = CGFloat(newValue) }
        get{ return Float(layer.cornerRadius) }
    }
}