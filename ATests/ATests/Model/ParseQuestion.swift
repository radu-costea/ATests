//
//  ParseQuestion.swift
//  ATests
//
//  Created by Radu Costea on 16/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

extension ParseQuestion {
    @NSManaged var parseContent: [PFObject]?
    @NSManaged var parseAnswer: [PFObject]?
    @NSManaged var domain: ParseDomain?
    
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
    
    convenience init(question: ParseQuestion) {
        self.init(className: "ParseQuestion")
        parseContent = question.parseContent?.flatMap{ $0.copyObject() }
        parseAnswer = question.parseAnswer?.flatMap{ $0.copyObject() }
        domain = question.domain
    }
    
    override func copyObject() -> ParseQuestion {
        return ParseQuestion(question: self)
    }
    
    override func isValid() -> Bool {
        return (content?.isValid() ?? false) && (answer?.isValid() ?? false)
    }
}

class ParseQuestion: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseQuestion"
    }
}
