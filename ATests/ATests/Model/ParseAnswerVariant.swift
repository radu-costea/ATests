//
//  ParseAnswerVariant.swift
//  ATests
//
//  Created by Radu Costea on 17/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

extension PFObject: ContentModel {
    func isValid() -> Bool {
        return true
    }
}

extension ParseAnswerVariant: AnswerVariant {
    @NSManaged var parseContent: PFObject?
    @NSManaged var index: Int32
    @NSManaged var correct: Bool
    @NSManaged var owner: ParseVariantsAnswerContent?
    
    var answerContent: NewVariantsAnswerContent? {
        get { return owner }
        set { owner = newValue as? ParseVariantsAnswerContent }
    }
    
    
    var content: ContentModel? {
        get { return parseContent as? ContentModel }
        set { parseContent = newValue.flatMap{ $0 as? PFObject }}
    }
}

final class ParseAnswerVariant: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseAnswerVariant"
    }
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    class func createObject() -> ParseAnswerVariant {
        return ParseAnswerVariant(className: parseClassName())
    }
}
