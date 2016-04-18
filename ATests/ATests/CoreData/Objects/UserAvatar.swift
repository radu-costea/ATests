//
//  UserAvatar.swift
//  ATests
//
//  Created by Radu Costea on 14/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class UserAvatar: Image {

// Insert code here to add functionality to your managed object subclass
    func image() -> UIImage? {
        guard let data = self.base64String?.toBase64Data() else {
            return nil
        }
        return UIImage(data: data)
    }

    func updateWithImage(image: UIImage) {
        self.base64String = UIImageJPEGRepresentation(image, 0.8)?.toBase64String()
    }
}
