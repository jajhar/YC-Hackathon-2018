//
//  UIImage+Extensions.swift
//  Hackathon
//
//  Created by James Ajhar on 6/30/18.
//  Copyright © 2018 James Ajhar. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    static func resizeImage(image: UIImage, newWidth: CGFloat, newHeight: CGFloat) -> UIImage? {
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0,width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func jpegRepresentation(compression: CGFloat = 1.0) -> Data? {
        return UIImageJPEGRepresentation(self, compression)
    }
}
