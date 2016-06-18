//
//  PFExamAnswer.swift
//  ATests
//
//  Created by Radu Costea on 18/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

class ParseExamAnswer: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseExamAnswer"
    }
}

extension ParseExamAnswer {
    @NSManaged var owner: ParseUser
    @NSManaged var question: ParseExamQuestion
    @NSManaged var exam: ParseExam
    @NSManaged var variants: [ParseAnswerVariant]
}