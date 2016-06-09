//
//  LiteAnswerVariant.swift
//  ATests
//
//  Created by Radu Costea on 09/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData

@objc(LiteAnswerVariant)
class LiteAnswerVariant: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

}

extension LiteAnswerVariant: AnswerVariant {
    var index: Int32 {
        get { return variantIndex }
        set { variantIndex = newValue }
    }
    
    var correct: Bool {
        get { return isCorrect }
        set { isCorrect = newValue }
    }
    
    var content: LiteContent? {
        get { return contentObject }
        set { contentObject = newValue }
    }
}


//extension LiteAnswerVariant: Equatable { }
func ==<T: LiteAnswerVariant>(lhs: T, rhs: T) -> Bool {
    return lhs.content == rhs.content && rhs.correct == lhs.correct
}