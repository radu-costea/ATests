//
//  ParseSimulationQuestion.swift
//  ATests
//
//  Created by Radu Costea on 18/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

extension ParseExamQuestion {
    @NSManaged var parseContent: [PFObject]?
    @NSManaged var parseAnswer: [PFObject]?
    @NSManaged var points: Int
    
    var content: PFObject? {
        get { return parseContent?.first }
        set {
            guard let newContent = newValue else {
                parseContent = nil
                return
            }
            parseContent = [newContent]
        }
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

extension ParseExamQuestion {
    convenience init(question: ParseQuestion, points: Int = 1) {
        self.init()
        content = question.content
        answer = question.answer
        self.points = points
    }
}

class ParseExamQuestion: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseExamQuestion"
    }
}
