//
//  ParseTextContent.swift
//  ATests
//
//  Created by Radu Costea on 16/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

extension ParseTextContent {
    @NSManaged var text: String?
}

extension ParseTextContent {
    override func isValid() -> Bool {
        return (text?.length ?? 0) > 0
    }
}

class ParseTextContent: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseTextContent"
    }
}
