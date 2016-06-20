//
//  ParseExam.swift
//  ATests
//
//  Created by Radu Costea on 18/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

@objc enum ParseExamState: Int {
    case NotStarted = 0
    case WaitingForClients
    case Started
    case Ended
}

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
    @NSManaged var clients: [ParseClientExam]?
    @NSManaged var state: ParseExamState
    @NSManaged var results: [ParseExam]
}
