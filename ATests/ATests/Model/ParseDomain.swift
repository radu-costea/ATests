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
    @NSManaged var questions: [ParseQuestion]?
    @NSManaged var owner: ParseUser?
}

class ParseDomain: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseDomain"
    }
}
