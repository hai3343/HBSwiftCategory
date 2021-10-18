//
//  DispatchQueue+Extension.swift
//  HBSwiftCategory
//
//  Created by 胡海兵 on 2021/9/23.

import UIKit

extension DispatchQueue {
    
    //MARK: 异步提交延迟操作到主线程
    /// 异步提交延迟操作到主线程
    ///
    /// - Parameters:
    ///   - dealyTime: 延迟时间 相对于当前时间
    ///   - callBack: 回调
    public class func hb_asyncAfterOnMain(dealyTime: Double, callBack: (()->Void)?) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + dealyTime) {
            
            callBack?()
        }
    }
    
    private static var _identifernTracker: [String] = []
    
    /// 保证整个生命周期只执行一次
    ///
    /// - Parameters:
    ///   - identifer: identifer
    ///   - block: 回调
    public class func hb_once(_ identifer: String, block: @escaping ()->Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        if _identifernTracker.contains(identifer) {
            return
        }
        _identifernTracker.append(identifer)
        DispatchQueue.main.async {
            block()
        }
    }
}
