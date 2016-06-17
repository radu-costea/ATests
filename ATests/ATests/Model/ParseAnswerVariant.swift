//
//  ParseAnswerVariant.swift
//  ATests
//
//  Created by Radu Costea on 17/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

extension ParseAnswerVariant {
    @NSManaged var content: PFObject?
    @NSManaged var index: Int32
    @NSManaged var correct: Bool
    @NSManaged var owner: ParseVariantsAnswerContent?
}

class ParseAnswerVariant: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseAnswerVariant"
    }
}
