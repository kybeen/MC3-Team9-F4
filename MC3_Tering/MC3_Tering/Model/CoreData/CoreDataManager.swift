//
//  CoreDataManager.swift
//  MC3_Tering
//
//  Created by KimTaeHyung on 2023/07/25.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UserInfo")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - CRUD Methods
    
    func create(entityName: String, attributes: [String: Any]) -> NSManagedObject? {
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            return nil
        }
        
        let object = NSManagedObject(entity: entity, insertInto: context)
        object.setValuesForKeys(attributes)
        
        do {
            try context.save()
            return object
        } catch {
            print("Failed to create object: \(error)")
            return nil
        }
    }
    
    func fetch(entityName: String, predicate: NSPredicate? = nil) -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = predicate
        
        do {
            let result = try context.fetch(fetchRequest)
            return result as? [NSManagedObject] ?? []
        } catch {
            print("Failed to fetch objects: \(error)")
            return []
        }
    }
    
    func update(object: NSManagedObject) {
        do {
            try context.save()
        } catch {
            print("Failed to update object: \(error)")
        }
    }
    
    func delete(object: NSManagedObject) {
        context.delete(object)
        
        do {
            try context.save()
        } catch {
            print("Failed to delete object: \(error)")
        }
    }
}
