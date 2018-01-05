//
//  CoreDataStack.swift
//  Dog Walk
//
//  Created by 刘松坡 on 14/11/8.
//  Copyright (c) 2014年 刘松坡. All rights reserved.
//

import CoreData

class CoreDataStack {
    
    let context: NSManagedObjectContext
    let psc: NSPersistentStoreCoordinator
    let model: NSManagedObjectModel
    let store: NSPersistentStore?
    
    init() {
        //1.The first step is to load the managed object model from disk into a NSManagedObjectModel object. You do this by getting a URL to the momd directory that contains the compiled version of the .xcdatamodeld file.
        let bundel = NSBundle.mainBundle()
        let modelUrl = bundel.URLForResource("Dog Walk", withExtension: "momd")
        model = NSManagedObjectModel(contentsOfURL: modelUrl!)!
        
        //2.Once you’ve initialized NSManagedObjectModel, the next step is to create NSPersistentStoreCoordinator. Remember that the persistent store coordinator mediates between the persistent store and NSManagedObjectModel. Initialize one using the NSManagedObjectModel you just created.
        psc = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        //3.The NSManagedObjectContext takes no arguments to initialize. However, it won’t be very useful until you connect it to an NSPersistentStoreCoordinator. You can do this easily by setting the context’s persistentStoreCoordinator property to the persistent store coordinator you just created in the previous step.
        context = NSManagedObjectContext()
        context.persistentStoreCoordinator = psc
        
        //4.The way you create a persistent store is a bit unintuitive—you don’t initialize it directly. Instead, the persistent store coordinator hands you an NSPersistentStore object as a side effect of attaching a persistent store type. You simply have to specify the store type (NSSQLiteStoreType in this case), the URL location of the store file and some configuration options.
        let documentsURL = applicationDocumentDirectory()
        let storeUrl = documentsURL.URLByAppendingPathComponent("Dog Walk")
        let options = [NSMigratePersistentStoresAutomaticallyOption: true]
        
        var error: NSError?
        store = psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeUrl, options: options, error: &error)
        
        
        if store == nil {
            println("Error adding persistent store: \(error)")
            abort()
        }
    }
    
    func saveContent() {
        var error: NSError? = nil
        if context.hasChanges && !context.save(&error) {
            println("Could not save \(error) , \(error?.userInfo)")
        }
    }
    
    func applicationDocumentDirectory() -> NSURL {
        let fileManager = NSFileManager.defaultManager()
        
        let urls = fileManager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)
        
        return urls[0] as NSURL
    }
    
}
