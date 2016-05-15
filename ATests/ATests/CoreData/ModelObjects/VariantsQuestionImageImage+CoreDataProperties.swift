//
//  VariantsQuestionImageImage+CoreDataProperties.swift
//  ATests
//
//  Created by Radu Costea on 12/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension VariantsQuestionImageImage {

    @NSManaged var contentObj: ImageContentObject?
    @NSManaged var answerObj: ImageVariantsAnswerObject?

}
