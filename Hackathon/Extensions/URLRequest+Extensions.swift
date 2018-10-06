//
//  URLSession+Extensions.swift
//  Hackathon
//
//  Created by James on 4/26/18.
//  Copyright © 2018 James. All rights reserved.
//

import Foundation

extension URLRequest {
    
    mutating func encodeRequestBody<T: Encodable>(_ body: T) {
        
        let encoder = JSONEncoder()
        
        do {
            self.httpBody = try encoder.encode(body)
        } catch let error {
            print("\(#function): Invalid request body: \(error)")
        }
    }
}

