//
//  ParseUser.swift
//  ATests
//
//  Created by Radu Costea on 16/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

class ParseUser: PFUser {
    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var avatar: PFFile?
    @NSManaged var domains: [ParseDomain]?
    
    override var parseClassName: String {
        return "ParseUser"
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
