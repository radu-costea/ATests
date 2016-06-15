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
    
    override func constructCopyParams() -> [String : AnyObject]? {
        var params = [String : AnyObject]()
        params["size"] = NSNumber(longLong: size)
        if let superParams = super.constructCopyParams() {
            params = params.join(superParams)
        }
        if let img = base64Image {
            params["base64Image"] = img
        }
        return params
    }
    
    override func makeCopy<T : LiteContent>() -> T? {
        return LiteImageContent(with: constructCopyParams()) as? T
    }
    
// Insert code here to add functionality to your managed object subclass
    override func isValid() -> Bool {
        return size > 0
    }
}
