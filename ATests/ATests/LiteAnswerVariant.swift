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
    
    func createCopyParams() -> [String: AnyObject]? {
        var params: [String: AnyObject] =  ["index": NSNumber(int: index), "correct" : NSNumber(bool: correct)]
        if let contentClone = content?.makeCopy() {
            params["content"] = contentClone
        }
        return params
    }
    
    func makeCopy<T: LiteAnswerVariant>() -> T? {
        return LiteAnswerVariant(with: createCopyParams()) as? T
    }

// Insert code here to add functionality to your managed object subclass
    func isValid() -> Bool {
        return content?.isValid() ?? false
    }

}

extension LiteAnswerVariant: AnswerVariant {
    override var hasDeepChanges: Bool {
        return super.hasDeepChanges || (content?.hasDeepChanges ?? false)
    }
    
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