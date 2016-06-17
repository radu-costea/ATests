//
//  ParseVariantsAnswerContent.swift
//  ATests
//
//  Created by Radu Costea on 16/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

extension ParseVariantsAnswerContent: NewVariantsAnswerContent {
    @NSManaged var parseVariants: [ParseAnswerVariant]?
    
    var variants: [AnswerVariant]? {
        get { return parseVariants }
        set { parseVariants = newValue?.flatMap{ $0 as? ParseAnswerVariant }}
    }
    
    var sortedVariants: [AnswerVariant]? {
        get {
            guard let p = parseVariants where p.count > 0 else {
                return nil
            }
            
            print("variants: \(p)")
            return p /*;.sort{ prev, next in
                guard let obj1 = prev.createdAt, let obj2 = next.createdAt else {
                    return true
                }
                return obj1.compare(obj2) == .OrderedAscending
            }*/
        }
        set { parseVariants = newValue?.flatMap{ $0 as? ParseAnswerVariant }}
    }
    
    func loadVariantsInBackgroundWithBlock(block: (([PFObject]?, NSError?) -> Void)?) {
        let querry = PFQuery(className: "ParseAnswerVariant")
        querry.whereKey("owner", equalTo: self)
        querry.findObjectsInBackgroundWithBlock { (objects, error) in
            if let _ = error {
                block?(nil, error)
                return
            }
            let variants = objects?.flatMap{ $0 as? ParseAnswerVariant }
            block?(variants, error)
        }
    }
}

class ParseVariantsAnswerContent: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseVariantsAnswerContent"
    }
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
}