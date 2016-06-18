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
    func loadVariantsInBackgroundWithBlock(block: (([PFObject]?, NSError?) -> Void)?) {
        let querry = PFQuery(className: "ParseAnswerVariant")
        querry.whereKey("owner", equalTo: self)
        querry.findObjectsInBackgroundWithBlock { (objects, error) in
            if let _ = error {
                block?(nil, error)
                return
            }
            let variants = objects?.flatMap{ $0 as? ParseAnswerVariant }
            block?(variants, error)
        }
    }
}

class ParseAnswer: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseAnswer"
    }
}
