//
//  AnswerVariantObject+CoreDataProperties.swift
//  ATests
//
//  Created by Radu Costea on 05/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension AnswerVariantObject {

    @NSManaged var orderIdx: Int32
    @NSManaged var isCorrect: Bool

}