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
//        if let contentClone = content?.makeCopy() {
//            params["content"] = contentClone
//        }
        return params
    }
    
    func makeCopy<T: LiteAnswerVariant>() -> T? {
        return LiteAnswerVariant(with: createCopyParams()) as? T
    }
    
    var answerContent: NewVariantsAnswerContent? {
        get { return nil }
        set { }
    }

// Insert code here to add functionality to your managed object subclass
    func isValid() -> Bool {
        return content?.isValid() ?? false
    }

}

extension LiteAnswerVariant: AnswerVariant {
    
    override var hasDeepChanges: Bool {
        return false;
//        return super.hasDeepChanges || (content?.hasDeepChanges ?? false)
    }
    
    var index: Int32 {
        get { return variantIndex }
        set { variantIndex = newValue }
    }
    
    var correct: Bool {
        get { return isCorrect }
        set { isCorrect = newValue }
    }
    
    var content: ContentModel? {
        get { return contentObject as? ContentModel }
        set { contentObject = newValue as? LiteContent }
    }
}


//extension LiteAnswerVariant: Equatable { }
func ==<T: LiteAnswerVariant>(lhs: T, rhs: T) -> Bool {
    return lhs.content?.objectId == rhs.content?.objectId && rhs.correct == lhs.correct
}