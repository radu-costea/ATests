//
//  ParseDomain.swift
//  ATests
//
//  Created by Radu Costea on 16/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

extension ParseDomain {
    @NSManaged var title: String?
    @NSManaged var owner: ParseUser?
    
    func fetchQuestionsInBackgroundWithBlock(block: (([ParseQuestion]?, NSError?) -> Void)?) {
        let query = PFQuery(className: "ParseQuestion")
        query.whereKey("domain", equalTo: self)
        query.includeKey("parseContent")
        query.includeKey("parseAnswer")
        
        query.findObjectsInBackgroundWithBlock({ (objects, error) in
            let questions = objects?.flatMap{ $0 as? ParseQuestion }
            block?(questions, error)
        })
    }
}

class ParseDomain: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseDomain"
    }
}
