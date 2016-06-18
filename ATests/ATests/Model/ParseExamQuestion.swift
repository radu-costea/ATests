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
    @NSManaged var question: ParseQuestion?
    @NSManaged var weight: Int
}

class ParseExamQuestion: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseExamQuestion"
    }
}
