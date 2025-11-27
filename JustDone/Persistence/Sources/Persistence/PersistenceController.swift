//
//  Persistence.swift
//  JustDone
//
//  Created by Hnat Danylevych on 27.11.2025.
//

import CoreData

struct PersistenceController {
    
    let container: NSPersistentContainer
    let mainContext: NSManagedObjectContext
    
    init() {
        let modelName = "JustDone"
        
        guard let modelURL = Bundle.module.url(forResource: modelName, withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("❌ Failed to locate or load Core Data model named \(modelName)")
        }
        
        container = NSPersistentContainer(name: modelName, managedObjectModel: model)
        mainContext = container.viewContext
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
