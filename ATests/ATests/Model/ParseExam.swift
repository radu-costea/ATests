//
//  ParseExam.swift
//  ATests
//
//  Created by Radu Costea on 18/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

class ParseExam: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseExam"
    }
}

extension ParseExam {
    @NSManaged var questions: [ParseExamQuestion]?
    @NSManaged var owner: ParseUser?
    @NSManaged var joinId: String?
    @NSManaged var duration: Int
    @NSManaged var clients: [ParseUser]?
    @NSManaged var state: Int
    @NSManaged var results: [ParseExam]
}
