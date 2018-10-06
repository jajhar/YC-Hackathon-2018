//
//  LocalCoordinator.swift
//  Hackathon
//
//  Created by James Ajhar on 6/16/18.
//  Copyright © 2018 James Ajhar. All rights reserved.
//

import Foundation
import CoreData

enum LocalCoordinatorError: Error {
    case userCreateFailed
    case userUpdateFailed
    case userFetchFailed
    case userSaveFailed
    case deallocated
}

class LocalCoordinator {
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Hackathon")
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
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
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

extension LocalCoordinator {
    
    func setCurrentUser(user: User, completion: ((User?, Error?) -> Void)? = nil) {
        
        deleteAllUsers { [weak self] (error) in
            
            guard error == nil else {
                completion?(nil, error)
                return
            }
            
            guard let strongSelf = self else {
                completion?(nil, LocalCoordinatorError.deallocated)
                return
            }
            
            let context = strongSelf.persistentContainer.viewContext
            context.perform {
                
                do {
                    guard let description = NSEntityDescription.entity(forEntityName: "\(UserMO.self)", in: context) else {
                        completion?(nil, LocalCoordinatorError.userCreateFailed)
                        return
                    }
                    
                    // Create the user
                    let userMO = UserMO.init(entity: description, insertInto: context)
                    userMO.update(fromUserModel: user)
                    
                    try context.save()
                    
                    let threadSafeUser = UserObject(fromUserMO: userMO)
                    completion?(threadSafeUser, nil)
                    
                } catch {
                    print("Error: \(error)")
                    completion?(nil, error)
                }
            }
        }
    }
    
    func updateCurrentUser(withProperties user: User, completion: ((User?, Error?) -> Void)? = nil) {
        
        let context = persistentContainer.viewContext
        context.perform {
            
            do {
                // Creates request for fetching User
                let request: NSFetchRequest<UserMO> = NSFetchRequest(entityName: "UserMO")
                
                // try to get the current user
                guard let existingObject = try context.fetch(request).first else {
                    completion?(nil, LocalCoordinatorError.userFetchFailed)
                    return
                }
                
                // Update the user
                existingObject.update(fromUserModel: user)
                
                try context.save()
                
                let threadSafeUser = UserObject(fromUserMO: existingObject)
                completion?(threadSafeUser, nil)
                
            } catch {
                print("Error: \(error)")
                completion?(nil, error)
            }
        }
    }
    
    /// Call to fetch a thread safe user object converted from NSManagedObject
    ///
    /// - Returns: A user object
    func currentUser() -> User? {
        
        let context = persistentContainer.viewContext
        
        var loggedInUser: User? = nil
        context.performAndWait {
            do {
                // Creates request for fetching User
                let request: NSFetchRequest<UserMO> = NSFetchRequest(entityName: "UserMO")

                // try to get the current user
                if let existingObject = try context.fetch(request).first {
                    loggedInUser = UserObject(fromUserMO: existingObject)
                }
                
            } catch {
                print("Error: \(error)")
            }
        }
        return loggedInUser
    }
    
    /// Deletes all users in the cache
    ///
    /// - Parameter completion: Called when all user objects have been deleted
    func deleteAllUsers(_ completion: ((Error?) -> Void)? = nil) {
        
        let fetchRequest = NSFetchRequest<UserMO>(entityName: "UserMO")
        
        let context = persistentContainer.viewContext
        context.performAndWait { [weak self] in
            do {
                guard let strongSelf = self else {
                    completion?(LocalCoordinatorError.deallocated)
                    return
                }
                
                let results = try context.fetch(fetchRequest)
                results.forEach({ context.delete($0) })
                
                strongSelf.saveContext()
                completion?(nil)
                
            } catch let error as NSError {
                print("Error: \(error)")
                completion?(error)
            }
        }
    }
}
