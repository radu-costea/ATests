//
//  LiteImageContent.swift
//  ATests
//
//  Created by Radu Costea on 09/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData

@objc(LiteImageContent)
class LiteImageContent: LiteContent {

// Insert code here to add functionality to your managed object subclass
    override func isValid() -> Bool {
        return base64Image?.length > 0
    }
}