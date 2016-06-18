//
//  UIImage-Extensions.swift
//  ATests
//
//  Created by Radu Costea on 14/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import UIKit
import Parse

extension UIImage {
    var base64String: String? {
        return UIImageJPEGRepresentation(self, 0.8)?.toBase64String()
    }
}