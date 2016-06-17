//
//  ParseTextContent.swift
//  ATests
//
//  Created by Radu Costea on 16/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

extension ParseTextContent: TextContent {
    @NSManaged var text: String?
    
    override func isValid() -> Bool {
        return (text?.length ?? 0) > 0
    }
}

class ParseTextContent: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseTextContent"
    }
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
//    required override init() {
//        super.init()
//    }
}
