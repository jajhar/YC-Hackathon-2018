//
//  UserMO.swift
//  Hackathon
//
//  Created by James Ajhar on 6/16/18.
//  Copyright © 2018 James Ajhar. All rights reserved.
//

import Foundation
import CoreData

class UserMO: NSManagedObject, User {
    
    @NSManaged public var identifier: String
    @NSManaged public var email: String
    
    /// Update Entity Properties from User protocol
    ///
    /// - Parameter model: The user model to update from
    func update(fromUserModel model: User) {
        self.identifier = model.identifier
        self.email = model.email
    }
}
