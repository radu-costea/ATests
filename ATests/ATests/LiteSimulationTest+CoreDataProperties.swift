//
//  LiteSimulationTest+CoreDataProperties.swift
//  ATests
//
//  Created by Radu Costea on 14/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension LiteSimulationTest {

    @NSManaged var creationDate: NSTimeInterval
    @NSManaged var duration: NSTimeInterval
    @NSManaged var startDate: NSTimeInterval
    @NSManaged var clientsTests: NSSet?
    @NSManaged var owner: User?
    @NSManaged var questions: NSSet?

}
