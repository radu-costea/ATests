//
//  LiteClientQuestion+CoreDataProperties.swift
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

extension LiteClientQuestion {

    @NSManaged var answer: LiteAnswer?
    @NSManaged var question: LiteSimulationQuestion?
    @NSManaged var test: LiteClientTest?

}
