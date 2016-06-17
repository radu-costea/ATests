//
//  ParseQuestion.swift
//  ATests
//
//  Created by Radu Costea on 16/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

extension ParseQuestion: QuestionModel {
    typealias ContentType = PFObject
    typealias AnswerType = ParseAnswer
    
    @NSManaged var parseContent: [PFObject]?
    @NSManaged var answer: ParseAnswer?
    @NSManaged var domain: ParseDomain?
    
    var content: ContentType? {
        get {
            return parseContent?.first
        }
        set {
            guard let newContent = newValue else {
                parseContent = nil
                return
            }
            parseContent = [newContent]
        }
    }
    
    override func isValid() -> Bool {
        return true;
    }
}

class ParseQuestion: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseQuestion"
    }
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
}
