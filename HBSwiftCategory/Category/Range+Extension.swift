//
//  Range-Extension.swift
//  HBSwiftCategory
//
//  Created by 胡海兵 on 2021/9/23.
//

import UIKit

public extension NSRange{

   /// 获取某一个字符串在总字符串中的区间range
    static func range(allText:String,rangeText:String)->NSRange{
        let range:NSRange =  (allText as NSString).range(of:rangeText)
        
       return range

    }

}
