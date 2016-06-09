//
//  LiteQuestion+CoreDataProperties.swift
//  ATests
//
//  Created by Radu Costea on 09/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension LiteQuestion {

    @NSManaged var answerObject: LiteAnswer?
    @NSManaged var contentObject: LiteContent?
    @NSManaged var evaluatorObject: LiteEvaluator?

}
