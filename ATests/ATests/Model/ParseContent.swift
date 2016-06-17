//
//  ParseContent.swift
//  ATests
//
//  Created by Radu Costea on 16/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

protocol ParseContentContainer {
    var parseContent: [PFObject]? { get set }
    var content: ContentModel? { get set }
}

extension ParseContentContainer {
//    var content: ContentModel? {
//        get {
//            return parseContent?.first as? ContentModel
//        }
//        set {
//            guard let newContent = newValue as? PFObject else {
//                parseContent = nil
//                return
//            }
//            parseContent = [newContent]
//        }
//    }
}

extension PFObject {
    func fetchSubEntities(className:String, key: String, inBackgroundWithBlock block: (([PFObject]?, NSError?) -> Void)?) {
        let query = PFQuery(className: className)
        query.whereKey(key, equalTo: self)
        query.findObjectsInBackgroundWithBlock(block)
    }
}

//class ParseContent: PFObject, PFSubclassing {
//    class func myParseClassName() -> String {
//        return "ParseContent"
//    }
//    
//    static func parseClassName() -> String {
//        return myParseClassName()
//        fatalError("You should never instantiate ParseContent objects")
//    }
//    
//    override class func initialize() {
//        struct Static {
//            static var onceToken : dispatch_once_t = 0;
//        }
//        dispatch_once(&Static.onceToken) {
//            self.registerSubclass()
//        }
//    }
//    
////    required override init() {
////        super.init()
////    }
//}
//
//extension ParseContent: ContentModel {
//    var identifier: String? {
//        return objectId
//    }
//    
//    override func isValid() -> Bool {
//        return true
//    }
//}