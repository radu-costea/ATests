//
//  NSManagedObjectContext-Extensions.swift
//  ATests
//
//  Created by Radu Costea on 07/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData

enum SortCriteria {
    case ascending(String)
    case descending(String)
    
    func descriptor() -> NSSortDescriptor {
        switch self {
        case let .ascending(key):
            return NSSortDescriptor(key: key, ascending: true)
        case let .descending(key):
            return NSSortDescriptor(key: key, ascending: false)
        }
    }
}

extension NSManagedObjectContext {
    func fetchObjects(ofType type: String, with predicateFormat: String? = nil, limit: NSInteger? = nil, sortBy: [SortCriteria]? = nil) throws -> [AnyObject] {
        let request = NSFetchRequest(entityName: type, with: predicateFormat, limit: limit, sortBy: sortBy)
        return try self.executeFetchRequest(request)
    }
    
    func countObjects(ofType type: String, with predicateFormat: String? = nil, limit: NSInteger? = nil, sortBy: [SortCriteria]? = nil) -> Int {
        let request = NSFetchRequest(entityName: type, with: predicateFormat, limit: limit, sortBy: sortBy)
        request.resultType = .CountResultType
        var error: NSError?     = nil
        let count = countForFetchRequest(request, error: &error)
        return count
    }
}