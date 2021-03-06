//
//  ParseClientExam.swift
//  ATests
//
//  Created by Radu Costea on 19/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

extension ParseClientExam {
    @NSManaged var owner: ParseUser
    @NSManaged var displayName: String?
    @NSManaged var answers: [ParseExamAnswer]
    @NSManaged var source: ParseExam
    @NSManaged var startDate: NSDate?
    @NSManaged var endDate: NSDate?
    @NSManaged var grade: Float
}

class ParseClientExam: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseClientExam"
    }
}