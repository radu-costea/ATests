//
//  AnswerVariantObject.swift
//  ATests
//
//  Created by Radu Costea on 05/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData


class AnswerVariantObject: NSManagedObject, AnswerVariant {
    typealias ContentType = ContentObject
// Insert code here to add functionality to your managed object subclass
    var index: UInt {
        get { return UInt(orderIdx) }
        set { orderIdx = Int32(orderIdx) }
    }
    
    var correct: Bool {
        get { return isCorrect }
        set { isCorrect = newValue }
    }

}
