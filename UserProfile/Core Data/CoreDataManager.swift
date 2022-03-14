//
//  CoreDataManager.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/14/22.
//

import CoreData

// MARK: - Instance

class CoreDataManager {
    static let shared = CoreDataManager()

    private init() {
        
    }
    
    // MARK: - PersistentContainer
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "UserProfile")
        
        // TODO: Comment out if running unit tests
//        let description = NSPersistentStoreDescription()
//        description.url = URL(fileURLWithPath: "/dev/null")
//        self.persistentContainer.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Methods
    func find<T: NSManagedObject>(_ entity: T.Type,
                                  properties: [String: Any]?,
                                  predicate: NSPredicate?,
                                  sortDescriptors: [NSSortDescriptor]?,
                                  createIfNotFound: Bool) -> [T]? {
        
        let context = persistentContainer.viewContext
        let entityName = String(describing: entity)
        
        let request = NSFetchRequest<T>(entityName: entityName)
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        do {
            let objects = try context.fetch(request)
            
            if !objects.isEmpty {
                objects.forEach {
                    for (key,value) in properties ?? [:] {
                        $0.setValue(value, forKey: key)
                    }
                }
                return objects
            } else {
                if createIfNotFound {
                    if let desc = NSEntityDescription.entity(forEntityName: entityName, in: context) {
                        let object = NSManagedObject(entity: desc, insertInto: context)
                        
                        for (key,value) in properties ?? [:] {
                            object.setValue(value, forKey: key)
                        }
                        
                        saveContext()
                        return find(entity,
                                    properties: properties,
                                    predicate: predicate,
                                    sortDescriptors: sortDescriptors,
                                    createIfNotFound: createIfNotFound)
                    } else {
                        return nil
                    }
                } else {
                    return nil
                }
            }
        } catch {
            print("%@", error.localizedDescription)
            return nil
        }
    }
    
    // MARK: - Core Data Saving support

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
