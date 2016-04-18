//
//  NSManagedObject-Extensions.swift
//  ATests
//
//  Created by Radu Costea on 07/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData

protocol ActiveRecord: AnyObject {
    static func all(with predicateFormat: String?, limit: NSInteger?, sortBy: [SortCriteria]?) throws -> [AnyObject]
    static func count(with predicateFormat: String?, limit: NSInteger?, sortBy: [SortCriteria]?) -> Int
    static func find(with predicateFormat: String) throws -> AnyObject?
    static func new(with: [String: AnyObject]?) -> AnyObject?
}

/**
 *  @brief Active managed object
 */
protocol ActiveManagedObject: ActiveRecord {
    static func sharedContext() -> NSManagedObjectContext?
    func persist() throws
}

extension ActiveManagedObject {
    private static func all(inContext context: NSManagedObjectContext, with predicateFormat: String? = nil, limit: NSInteger? = nil, sortBy: [SortCriteria]? = nil) throws -> [AnyObject] {
        return try context.fetchObjects(ofType: String(Self), with: predicateFormat, limit: limit, sortBy: sortBy)
    }
    
    private static func new(inContext context: NSManagedObjectContext) -> NSManagedObject {
        return NSEntityDescription.insertNewObjectForEntityForName(String(Self), inManagedObjectContext: context)
    }
    
    private static func count(inContext context: NSManagedObjectContext, with predicateFormat: String?, limit: NSInteger?, sortBy: [SortCriteria]?) -> Int {
        return context.countObjects(ofType: String(Self), with: predicateFormat, limit: limit, sortBy: sortBy)
    }
    
    private static func find(inContext context: NSManagedObjectContext, with predicateFormat: String) throws -> AnyObject? {
        if count(inContext: context, with: predicateFormat, limit: nil, sortBy: nil) == 1 {
            return try all(inContext: context, with: predicateFormat, limit: nil, sortBy: nil).first!
        }
        return nil
    }
}

extension ActiveManagedObject {
    // MARK: - Active Record Implementation
    static func all(with predicateFormat: String? = nil, limit: NSInteger? = nil, sortBy: [SortCriteria]? = nil) throws -> [AnyObject] {
        guard let context = sharedContext() else {
            return []
        }
        return try all(inContext: context, with: predicateFormat, limit: limit, sortBy: sortBy)
    }
    
    static func count(with predicateFormat: String? = nil, limit: NSInteger? = nil, sortBy: [SortCriteria]? = nil) -> Int {
        guard let context = sharedContext() else {
            return 0
        }
        return count(inContext: context, with: predicateFormat, limit: limit, sortBy: sortBy)
    }
    
    static func find(with predicateFormat: String) throws -> AnyObject? {
        guard let context = sharedContext() else {
            return nil
        }
        return try find(inContext: context, with: predicateFormat)
    }
    
    static func new(with: [String: AnyObject]? = nil) -> AnyObject? {
        guard let context = sharedContext() else {
            return nil
        }
        let object = new(inContext: context)
        if let values = with {
            object.setValuesForKeysWithDictionary(values)
        }
        return object
    }
}

/**
 *  @brief Active managed object
 */
extension NSManagedObject: ActiveManagedObject {
    private static var sharedInstance: NSManagedObjectContext?
    static func sharedContext() -> NSManagedObjectContext? {
        return sharedInstance
    }
    
    static func configureWithContextManager(manager: ContextManager) -> Void {
        sharedInstance = manager.managedObjectContext
    }
    
    func persist() throws {
        try managedObjectContext?.save()
    }
    
    func tryPersit() {
        do {
            try persist()
        } catch { }
    }
}