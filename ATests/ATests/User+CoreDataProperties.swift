//
//  User+CoreDataProperties.swift
//  ATests
//
//  Created by Radu Costea on 15/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var email: String?
    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var password: String?
    @NSManaged var creationDate: NSTimeInterval
    @NSManaged var avatar: UserAvatar?
    @NSManaged var takenTests: NSSet?
    @NSManaged var tests: NSSet?

}
