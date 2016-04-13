//
//  ContextManager.swift
//  ATests
//
//  Created by Radu Costea on 12/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import CoreData

extension NSFileManager {
    var applicationDocumentsDirectoryURL: NSURL {
        return URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last!
    }
}

class ContextManager {
    // MARK: - Dependencies
    lazy var fileManager: NSFileManager = NSFileManager.defaultManager()
    lazy var managedObjectModel: NSManagedObjectModel = self.createManagedObjectModel()
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = self.createPersistentStoreCoordinator()
    lazy var managedObjectContext: NSManagedObjectContext = self.createManagedObjectContext()
    
    // MARK: - Core Data stack
    private(set) var modelFileName: String
    private(set) var storeFileName: String
    private(set) var concurencyType: NSManagedObjectContextConcurrencyType
    
    init(modelFileName: String, storeFileName: String, concurency: NSManagedObjectContextConcurrencyType) {
        self.modelFileName = modelFileName
        self.storeFileName = storeFileName
        self.concurencyType = concurency
    }
    
    // MARK: - Initializers
    
    private func createManagedObjectModel() -> NSManagedObjectModel {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource(self.modelFileName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }
    
    private func createManagedObjectContext() -> NSManagedObjectContext{
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        let context = NSManagedObjectContext(concurrencyType: self.concurencyType)
        context.persistentStoreCoordinator = coordinator
        return context
    }
    
    private func createPersistentStoreCoordinator() -> NSPersistentStoreCoordinator {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let filename = String("\(self.storeFileName).sqlite")
        let url = self.fileManager.applicationDocumentsDirectoryURL.URLByAppendingPathComponent(filename)
        let failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        guard managedObjectContext.hasChanges else {
            return
        }
        do {
            try managedObjectContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
}