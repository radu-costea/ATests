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
extension NSManagedObject: ActiveRecord {
    
    var hasDeepChanges: Bool {
        return hasChanges
    }
    
    // MARK: -
    // MARK: Object creation
    
    public convenience init?(with: [String : AnyObject]?) {
        guard let entity = NSEntityDescription.entityForName(String(self.dynamicType), inManagedObjectContext: NSManagedObject.sharedContext()) else {
            return nil
        }
        self.init(entity: entity, insertIntoManagedObjectContext: NSManagedObject.sharedContext())
        if let values = with {
            setValuesForKeysWithDictionary(values)
        }
    }
    
    static func new(with: [String: AnyObject]? = nil) -> AnyObject? {
        let object = new(inContext: sharedContext())
        if let values = with {
            object.setValuesForKeysWithDictionary(values)
        }
        return object
    }
    
    // MARK: -
    // MARK: Active record implementation
    
    class func all(with predicateFormat: String? = nil, limit: NSInteger? = nil, sortBy: [SortCriteria]? = nil) throws -> [AnyObject] {
        return try all(inContext: sharedContext(), with: predicateFormat, limit: limit, sortBy: sortBy)
    }
    
    class func count(with predicateFormat: String? = nil, limit: NSInteger? = nil, sortBy: [SortCriteria]? = nil) -> Int {
        return count(inContext: sharedContext(), with: predicateFormat, limit: limit, sortBy: sortBy)
    }
    
    class func find(with predicateFormat: String) throws -> AnyObject? {
        return try find(inContext: sharedContext(), with: predicateFormat)
    }
    
    // MARK: - 
    // MARK: Save & setup
    
    func persist() throws {
        try managedObjectContext?.save()
    }
    
    func rollback() {
        managedObjectContext?.rollback()
    }
    
    func tryPersit() {
        do {
            try persist()
        } catch { }
    }

    
    // MARK: -
    // MARK: Private helpers
    
    private static var sharedInstance: NSManagedObjectContext?
    private static func sharedContext() -> NSManagedObjectContext! {
        guard let instance = sharedInstance else {
            fatalError("Tried to use context before setup")
        }
        return instance
    }
    
    static func configureWithContextManager(manager: ContextProvider) -> Void {
        sharedInstance = manager.managedObjectContext
    }
    
    // MARK: -
    // MARK: Active record like but with a context passed
    
    public class func all(inContext context: NSManagedObjectContext, with predicateFormat: String? = nil, limit: NSInteger? = nil, sortBy: [SortCriteria]? = nil) throws -> [AnyObject] {
        return try context.fetchObjects(ofType: String(self), with: predicateFormat, limit: limit, sortBy: sortBy)
    }
    
    public class func new(inContext context: NSManagedObjectContext) -> NSManagedObject {
        return NSEntityDescription.insertNewObjectForEntityForName(String(self.dynamicType), inManagedObjectContext: context)
    }
    
    public class func count(inContext context: NSManagedObjectContext, with predicateFormat: String?, limit: NSInteger?, sortBy: [SortCriteria]?) -> Int {
        return context.countObjects(ofType: String(self), with: predicateFormat, limit: limit, sortBy: sortBy)
    }
    
    public static func find(inContext context: NSManagedObjectContext, with predicateFormat: String) throws -> AnyObject? {
        guard count(inContext: context, with: predicateFormat, limit: nil, sortBy: nil) == 1 else {
            return nil
        }
        return try all(inContext: context, with: predicateFormat, limit: nil, sortBy: nil).first
    }
}