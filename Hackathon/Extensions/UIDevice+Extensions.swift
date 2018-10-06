//
//  UIDevice+Extensions.swift
//  Hackathon
//
//  Created by James Ajhar on 8/26/18.
//  Copyright © 2018 James Ajhar. All rights reserved.
//

import UIKit

extension UIDevice {
    
    var isIphoneX: Bool {
        
        if userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2436:
                return true
            default:
                return false
            }
        }
        
        return false
    }
    
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}
