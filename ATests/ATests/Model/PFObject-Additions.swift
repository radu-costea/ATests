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
        return false
    }
    
    public func equalTo(object: AnyObject?) -> Bool {
        if let pfObject = object as? PFObject {
            return pfObject.objectId == objectId
        }
        return self.isEqual(object)
    }
}

func ==<T: PFObject>(lhs: Array<T>, rhs: Array<T>) -> Bool {
    guard lhs.count == rhs.count else {
        return false
    }
    for idx in 0..<lhs.count {
        print("comparing variant \(idx)")
        guard lhs[idx].equalTo(rhs[idx]) else {
            return false
        }
    }
    return true
}