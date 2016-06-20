//
//  ParseContent.swift
//  ATests
//
//  Created by Radu Costea on 16/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

protocol CopyableObject: class {
    func copyObject() -> PFObject
}

extension PFObject {
    func fetchSubEntities(className:String, key: String, inBackgroundWithBlock block: (([PFObject]?, NSError?) -> Void)?) {
        let query = PFQuery(className: className)
        query.whereKey(key, equalTo: self)
        query.findObjectsInBackgroundWithBlock(block)
    }
}

extension PFObject: CopyableObject {
    func copyObject() -> PFObject {
        return PFObject(className: parseClassName)
    }
    
    func cleanCopyObject() -> PFObject {
        return PFObject(className: parseClassName)
    }
}

extension PFObject {
    func isValid() -> Bool {
        return true
    }
}