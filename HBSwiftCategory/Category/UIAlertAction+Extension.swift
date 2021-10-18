//
//  UIAlertAction-Extension.swift
//  HBSwiftCategory
//
//  Created by 胡海兵 on 2021/9/23.
//

import Foundation
import UIKit
@objc public extension UIAlertAction{
    
   @objc convenience init(title:String?,image:UIImage?=nil, titleColor:UIColor?=nil,style:UIAlertAction.Style,handler:((UIAlertAction) -> Void)? = nil,isEnabled:Bool=true) {
        self.init(title: title, style: style, handler: handler)
        
        if let image = image{
           setValue(image, forKey: "image")
        }
 
        if let color = titleColor{
           setValue(color, forKey: "titleTextColor")
        }
        
        
    }
    
    
   
    
    
}

