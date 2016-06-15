//
//  LiteContent.swift
//  ATests
//
//  Created by Radu Costea on 09/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData

@objc(LiteContent)

class LiteContent: NSManagedObject {

    func constructCopyParams() -> [String: AnyObject]? {
        guard let id = identifier else {
            return nil
        }
        return ["identifier" : id]
    }
    
// Insert code here to add functionality to your managed object subclass
    func makeCopy<T: LiteContent>() -> T? {
        return LiteContent(with: self.constructCopyParams()) as? T
    }
}

extension LiteContent: ContentModel {
    func isValid() -> Bool {
        return true
    }
}

func ==<T: LiteContent>(lhs: T, rhs: T) -> Bool {
    guard let lhsIdentifier = lhs.identifier,
        let rhsIdentifier = rhs.identifier else {
            return (lhs.identifier == nil) && (rhs.identifier == nil)
    }
    return lhsIdentifier == rhsIdentifier
}