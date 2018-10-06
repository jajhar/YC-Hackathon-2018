//
//  APIRequest.swift
//  Hackathon
//
//  Created by James on 4/26/18.
//  Copyright © 2018 James. All rights reserved.
//

import Foundation

enum RequestType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum APIRequest: APIRequestProtocol {
    
    // Force unwrap here because we want it to hard crash immediately
    static let baseURL: URL = URL(string: "http://178.128.78.118:8080")!
    
    case login
    case register

    var methodType: RequestType {
        switch self {
        case .login, .register:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/user/login"
        case .register:
            return "/user/register"
        }
    }
}
