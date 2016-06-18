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
        self.init(className: ParseAnswer.parseClassName())
        variants = answer.variants?.flatMap{ ParseAnswerVariant(variant: $0) }
    }
}

class ParseAnswer: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseAnswer"
    }
}
