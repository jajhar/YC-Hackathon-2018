//
//  Threading.swift
//  Hackathon
//
//  Created by James Ajhar on 10/4/18.
//  Copyright © 2018 James Ajhar. All rights reserved.
//

import Foundation

func performOnMainThread(_ block: @escaping () -> Void) {
    if Thread.isMainThread {
        block()
    } else {
        DispatchQueue.main.async {
            block()
        }
    }
}
