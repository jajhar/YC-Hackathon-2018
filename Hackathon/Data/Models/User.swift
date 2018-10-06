//
//  User.swift
//  Hackathon
//
//  Created by James on 4/26/18.
//  Copyright © 2018 James. All rights reserved.
//

import Foundation

protocol User: class {
    var identifier: String { get }
    var email: String { get }
}

func == (lhs: User, rhs: User) -> Bool {
    return lhs.identifier == rhs.identifier
}

