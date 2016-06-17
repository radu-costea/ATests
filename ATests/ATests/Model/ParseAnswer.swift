//
//  ParseAnswer.swift
//  ATests
//
//  Created by Radu Costea on 16/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

extension ParseAnswer: AnswerModel {
    @NSManaged var content: ParseVariantsAnswerContent?
    
    override func isValid() -> Bool {
        do {
            try content?.fetchIfNeeded()
        } catch { }
        
        return content?.isValid() ?? false
    }
}

class ParseAnswer: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseAnswer"
    }
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
//    required override init() {
//        super.init()
//    }
}
