//
//  LiteTest.swift
//  ATests
//
//  Created by Radu Costea on 11/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData


class LiteTest: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

}

extension LiteTest {
    var sortedQuestions: [LiteQuestion]? {
        get { return questions?.allObjects.flatMap{ $0 as? LiteQuestion }.sort{ $0.creationDate < $1.creationDate } }
        set { questions = NSSet(array: newValue ?? []) }
    }
}

extension LiteTest: TimestampObject { }