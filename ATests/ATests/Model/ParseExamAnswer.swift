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
    @NSManaged var question: ParseExamQuestion
    @NSManaged var parseAnswer: [PFObject]?
    
    convenience init(question: ParseExamQuestion, answer: PFObject?) {
        self.init()
        self.question = question
        self.answer = answer
    }
    
    var answer: PFObject? {
        get { return parseAnswer?.first }
        set {
            guard let newContent = newValue else {
                parseAnswer = nil
                return
            }
            parseAnswer = [newContent]
        }
    }
}