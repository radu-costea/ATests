//
//  ParseAnswer.swift
//  ATests
//
//  Created by Radu Costea on 16/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

extension ParseAnswer {
    @NSManaged var variants: [ParseAnswerVariant]?
    @NSManaged var isValidAnswer: Bool
}



extension ParseAnswer {
    convenience init(answer: ParseAnswer) {
        self.init()
        do {
            try answer.fetchIfNeeded()
            variants = answer.variants?.flatMap{ $0.cleanCopyObject() }
            isValidAnswer = answer.isValidAnswer
        } catch {
            print("why me!!!")
        }
    }
    
    override func copyObject() -> ParseAnswer {
        return ParseAnswer(answer: self)
    }
    
    override func cleanCopyObject() -> ParseAnswer {
        return copyObject()
    }
    
    func updateValidState() -> Void {
        var isValid = true
        var isSelected = false
        variants?.forEach({ (variant) in
            isValid = (isValid && variant.isValid())
            isSelected = isSelected || variant.correct
        })
        isValidAnswer = isSelected && isValid
    }
    
    override func isValid() -> Bool {
        return isValidAnswer
    }
    
    override func equalTo(object: AnyObject?) -> Bool {
        if let answer = object as? ParseAnswer,
            let myVariants = variants?.sort({ $0.index < $1.index }),
            let otherVariants = answer.variants?.sort({ $0.index < $1.index }) {
            return myVariants == otherVariants
        }
        return super.equalTo(object)
    }
}

class ParseAnswer: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseAnswer"
    }
}
