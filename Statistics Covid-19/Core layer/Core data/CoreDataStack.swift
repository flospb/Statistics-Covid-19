//
//  CoreDataStack.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 28.08.2021.
//

import CoreData

protocol ICoreDataStack {
    var container: NSPersistentContainer { get set }
    func saveContext(in context: NSManagedObjectContext)
}

// check marks
class CoreDataStack: ICoreDataStack {
    private let dataBaseName = CoreDataConstants.dataBaseName

    // MARK: - ICoreDataStack

    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: dataBaseName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("something went wrong \(error) \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()

    public func saveContext(in context: NSManagedObjectContext) {
        context.performAndWait {
            if context.hasChanges {
                do {
                    try context.save()
                } catch let error as NSError {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            }
        }
    }
}