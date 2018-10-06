//
//  UserJSON.swift
//  Hackathon
//
//  Created by James Ajhar on 6/16/18.
//  Copyright © 2018 James Ajhar. All rights reserved.
//

import Foundation

class UserObject: User {
    
    private(set) var identifier: String = ""
    private(set) var email: String = ""
    
    convenience init(fromJSON json: [String: Any]) {
        self.init()
        self.identifier = json["id"] as? String ?? json["_id"] as? String ?? ""
        self.email = json["email"] as? String ?? ""
    }
    
    convenience init(fromUserMO userMO: UserMO) {
        self.init()
        self.identifier = userMO.identifier
        self.email = userMO.email
    }
}
