//
//  ParseDomain.swift
//  ATests
//
//  Created by Radu Costea on 16/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

extension ParseDomain: Domain {
    typealias QuestionType = ParseQuestion
    @NSManaged var title: String?
    @NSManaged var questions: [ParseQuestion]?
    @NSManaged var owner: ParseUser?
}

class ParseDomain: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseDomain"
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
