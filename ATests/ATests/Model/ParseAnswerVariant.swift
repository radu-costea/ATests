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
        self.init(className: "ParseAnswerVariant")
        do {
            try variant.fetchIfNeeded()
        } catch {
            print("exception thrown")
        }
        index = variant.index
        correct = variant.correct
        content = variant.content
    }
    
    override func copyObject() -> ParseAnswerVariant {
//        if self.objectId != nil {
//            do {
//                try self.fetchIfNeeded()
//            } catch {
//                print("exception thrown")
//            }
//        }
        return ParseAnswerVariant(variant: self)
    }
    
    override func cleanCopyObject() -> ParseAnswerVariant {
        let obj = copyObject()
        obj.correct = false
        return obj
    }
}

class ParseAnswerVariant: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseAnswerVariant"
    }
}
