//
//  TextAndImageQuestion+CoreDataProperties.swift
//  ATests
//
//  Created by Radu Costea on 15/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension TextAndImageQuestion {

    @NSManaged var text: String?
    @NSManaged var layout: NSNumber?

}
