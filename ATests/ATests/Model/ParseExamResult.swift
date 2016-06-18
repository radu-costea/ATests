//
//  ParseExamResult.swift
//  ATests
//
//  Created by Radu Costea on 18/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

class ParseExamResult: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseExamResult"
    }
}

extension ParseExamResult {
    @NSManaged var score: Int
    @NSManaged var owner: ParseUser
}
