//
//  DataCoordinator.swift
//  Hackathon
//
//  Created by James on 4/26/18.
//  Copyright © 2018 James. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

enum DataCoordinatorError: Error {
    case deallocated
    case unknown
    case userNotFound
}

class DataCoordinator {
    
    public static let shared: DataCoordinator = { DataCoordinator() }()
    
    internal let localCoordinator = LocalCoordinator()
    internal let remoteCoordinator = RemoteCoordinator()
    
    internal(set) var signedInUser: User?
    
    init() {
        signedInUser = localCoordinator.currentUser()
    }
}

extension DataCoordinator {
    
    func isUserSignedIn() -> Bool {
        return DataCoordinator.shared.signedInUser != nil && DataCoordinator.shared.signedInUser?.identifier.isEmpty == false
    }
    
    func clearCache() {
        localCoordinator.deleteAllUsers()
    }
    
    func logout() {
        clearCache()
    }
    
    func registerForRemoteNotifications() {
        let application = UIApplication.shared
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        
        application.registerForRemoteNotifications()
    }
    
    func loginUser(withEmail email: String, andPassword password: String, completion: @escaping ((User?, Error?) -> Void)) {
        
        remoteCoordinator.loginUser(withEmail: email, andPassword: password) { [weak self] (user, error) in
            
            guard let strongSelf = self else {
                performOnMainThread {
                    completion(nil, DataCoordinatorError.deallocated)
                }
                return
            }
            
            guard error == nil, let user = user else {
                performOnMainThread {
                    completion(nil, error ?? DataCoordinatorError.unknown)
                }
                return
            }
            
            // Save the user to cache and return
            strongSelf.localCoordinator.setCurrentUser(user: user, completion: { (user, error) in
                
                performOnMainThread {
                    guard error == nil else {
                        completion(nil, error)
                        return
                    }
                
                    strongSelf.signedInUser = user
                    completion(user, nil)
                    
                    strongSelf.registerForRemoteNotifications()
                }
            })
        }
    }
    
    func register(user: User, withEmail email: String, andPassword password: String, completion: @escaping ((User?, Error?) -> Void)) {
        
        remoteCoordinator.register(user: user, withEmail: email, andPassword: password) { [weak self] (user, error) in
            
            guard let strongSelf = self else {
                performOnMainThread {
                    completion(nil, DataCoordinatorError.deallocated)
                }
                return
            }
            
            guard error == nil, let user = user else {
                performOnMainThread {
                    completion(nil, error ?? DataCoordinatorError.unknown)
                }
                return
            }
            
            // Save the user to cache and return
            strongSelf.localCoordinator.setCurrentUser(user: user, completion: { (user, error) in
                
                performOnMainThread {
                    guard error == nil else {
                        completion(nil, error)
                        return
                    }
                    
                    strongSelf.signedInUser = user
                    completion(user, nil)
                }
            })
        }
    }
}
