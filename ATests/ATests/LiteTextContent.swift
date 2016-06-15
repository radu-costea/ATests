//
//  LiteTextContent.swift
//  ATests
//
//  Created by Radu Costea on 09/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData

@objc(LiteTextContent)
class LiteTextContent: LiteContent {
    
    override func constructCopyParams() -> [String : AnyObject]? {
        var params = [String : AnyObject]()
        if let superParams = super.constructCopyParams() {
            params = params.join(superParams)
        }
        if let txt = text {
            params["text"] = txt
        }
        return params
    }
    
    override func makeCopy<T : LiteContent>() -> T? {
        return LiteTextContent(with: constructCopyParams()) as? T
    }

// Insert code here to add functionality to your managed object subclass
    override func isValid() -> Bool {
        return text?.length > 0
    }
}
