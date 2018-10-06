//
//  RemoteCoordinator+User.swift
//  Hackathon
//
//  Created by James Ajhar on 8/23/18.
//  Copyright © 2018 James Ajhar. All rights reserved.
//

import Foundation
import KeychainSwift

extension RemoteCoordinator {
    
    func loginUser(withEmail email: String, andPassword password: String, completion: @escaping ((User?, Error?) -> Void)) {
        
        guard var request = APIRequest.login.request() else {
            completion(nil, RemoteError.apiError(message: "Failed to send request", errorCode: 0))
            return
        }
        
        //setup request
        let requestBody: JSONDictionary = ["email": email,
                                           "password": password]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: [])
        
        send(request: request) { (data, response, error) in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, RemoteError.apiError(message: "Response has no data", errorCode: 0))
                return
            }
            
            guard let json = self.jsonParse(data: data) as? JSONDictionary else {
                completion(nil, RemoteError.apiError(message: "Failed to parse JSON", errorCode: response?.statusCode))
                return
            }
            
            guard let userJSON = json["user"] as? JSONDictionary,
                let token = json["token"] as? String else
            {
                if let errorMessage = json["error"] as? String {
                    completion(nil, RemoteError.apiError(message: errorMessage, errorCode: response?.statusCode))
                } else {
                    completion(nil, RemoteError.apiError(message: "Failed to parse JSON", errorCode: response?.statusCode))
                }
                
                return
            }
            
            let user = UserObject(fromJSON: userJSON)
            
            // Store the Auth token
            let keychain = KeychainSwift()
            keychain.set(token, forKey: AppConstants.Keychain.remoteTokenKey)
            
            completion(user, nil)
        }
    }
    
    func register(user: User, withEmail email: String, andPassword password: String, completion: @escaping ((User?, Error?) -> Void)) {
        
        guard var request = APIRequest.register.request() else {
            completion(nil, RemoteError.apiError(message: "Failed to send request", errorCode: 0))
            return
        }
        
        // setup request
        let requestBody: JSONDictionary = ["email": email,
                                           "password": password]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: [])
        
        send(request: request) { (data, response, error) in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, RemoteError.apiError(message: "Response has no data", errorCode: response?.statusCode))
                return
            }
            
            guard let json = self.jsonParse(data: data) as? JSONDictionary else {
                completion(nil, RemoteError.apiError(message: "Failed to parse JSON", errorCode: response?.statusCode))
                return
            }
            
            guard let userJSON = json["user"] as? JSONDictionary,
                let token = json["token"] as? String else
            {
                if let errorMessage = json["error"] as? String {
                    completion(nil, RemoteError.apiError(message: errorMessage, errorCode: response?.statusCode))
                } else {
                    completion(nil, RemoteError.apiError(message: "Failed to parse JSON", errorCode: response?.statusCode))
                }
                
                return
            }
            
            let user = UserObject(fromJSON: userJSON)
            
            // Store the Auth token
            let keychain = KeychainSwift()
            keychain.set(token, forKey: AppConstants.Keychain.remoteTokenKey)
            
            completion(user, nil)
        }
        
    }
}
