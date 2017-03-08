//
//  UIImageExtensions.swift
//  PhotoCarousel
//
//  Created by Georgiev, Veliyan on 3/7/17.
//  Copyright © 2017 VillyG. All rights reserved.
//

import UIKit

extension UIImage {

    class func create(fromColor color: UIColor) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y:0), size: CGSize(width: 1, height: 1))
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
}
