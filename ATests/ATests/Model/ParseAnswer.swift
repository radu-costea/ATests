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
}



extension ParseAnswer {
    convenience init(answer: ParseAnswer) {
        self.init()
        variants = answer.variants?.flatMap{ $0.cleanCopyObject() }
    }
    
    override func copyObject() -> ParseAnswer {
        return ParseAnswer(answer: self)
    }
    
    override func cleanCopyObject() -> ParseAnswer {
        return copyObject()
    }
}

class ParseAnswer: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseAnswer"
    }
}
