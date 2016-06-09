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

// Insert code here to add functionality to your managed object subclass

}

extension LiteContent: ContentModel { }

func ==<T: LiteContent>(lhs: T, rhs: T) -> Bool {
    guard let lhsIdentifier = lhs.identifier,
        let rhsIdentifier = rhs.identifier else {
            return (lhs.identifier == nil) && (rhs.identifier == nil)
    }
    return lhsIdentifier == rhsIdentifier
}