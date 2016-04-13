//
//  NSFetchRequest-Extensions.swift
//  ATests
//
//  Created by Radu Costea on 07/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData

extension NSFetchRequest {
    convenience init(entityName: String, where predicateFormat: String?, limit: NSInteger?, sortBy: [SortCriteria]?) {
        self.init(entityName: entityName)
        if let format = predicateFormat {
            self.predicate = NSPredicate(format: format)
        }
        if let sort = sortBy {
            let descriptors = sort.map{ $0.descriptor() }
            self.sortDescriptors = descriptors
        }
        if let recordsLimit = limit {
            self.fetchLimit = recordsLimit
        }
    }
}