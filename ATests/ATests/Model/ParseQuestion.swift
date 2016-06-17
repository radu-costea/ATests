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
    @NSManaged var answer: ParseAnswer?
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
}

class ParseQuestion: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseQuestion"
    }
}
