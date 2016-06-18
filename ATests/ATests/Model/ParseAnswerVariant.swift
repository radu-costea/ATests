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
    @NSManaged var parseContent: [PFObject]?
    @NSManaged var index: Int32
    @NSManaged var correct: Bool
    @NSManaged var owner: ParseAnswer?
    
    
    var content: PFObject? {
        get { return parseContent?.first }
        set {
            guard let newContent = newValue else {
                parseContent = nil
                return
            }
            parseContent = [newContent]
        }
    }
}

extension ParseAnswerVariant {
    convenience init(variant: ParseAnswerVariant) {
        self.init(className: ParseAnswerVariant.parseClassName())
        index = variant.index
        correct = variant.correct
        content = variant.content
    }
}

class ParseAnswerVariant: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseAnswerVariant"
    }
}
