//
//  Timer+Ext.swift
//  ExtensionTool
//
//  Created by ZCC on 2018/7/19.
//  Copyright © 2018年 ZCC. All rights reserved.
//

import UIKit

public extension NSObject {
    
    /// 存储定时器使用
    fileprivate var hb_timers: [String: DispatchSourceTimer?]? {
        set {
            hb_setAssociatedObject(key: "hb_timers", value: newValue)
        }
        get { return hb_getAssociatedObject(key: "hb_timers") as? [String: DispatchSourceTimer?] }
    }
    
    //MARK: 启动定时器
    /// 启动定时器
    ///
    /// - Parameters:
    ///   - timerIdentifier: 唯一的标记符, 如果同一个对象只有一个定时器 可以不传
    ///   - timeInterval: 时间间隔
    ///   - repeats: 是否重复 true一直运行 false运行一次
    ///   - isDealy: 是否延迟时间间隔运行
    ///   - block: 回调
    func hb_startTimer(timerIdentifier: String? = nil, timeInterval: TimeInterval, repeats: Bool, isDealy: Bool = true, block: @escaping (DispatchSourceTimer?)->Void) {
        
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        timer.schedule(wallDeadline: DispatchWallTime.now(), repeating: timeInterval)
        var count: Int = 0
        timer.setEventHandler { [unowned self] in
            
            if !repeats && count == 1 {
                
                self.hb_stopTimer(timerIdentifier: timerIdentifier)
                return
            }
            count += 1
            if let hb_timers = self.hb_timers {
                
                let key = timerIdentifier ?? "timer"
                block(hb_timers[key] as? DispatchSourceTimer)
                
            } else {
                
                block(nil)
            }
        }
        if isDealy {
            
            DispatchQueue.hb_asyncAfterOnMain(dealyTime: timeInterval) {
                
                timer.resume()
            }

        } else {
            
            timer.resume()
        }
        
        var timers = self.hb_timers ?? [:]
        timers[timerIdentifier ?? "timer"] = timer
        self.hb_timers = timers
    }
    
    //MARK: 销毁定时器
    /// 销毁定时器
    ///
    /// - Parameter timerIdentifier: 定时器唯一标记符
    func hb_stopTimer(timerIdentifier: String? = nil) {
        
        let key = timerIdentifier ?? "timer"
        var timers = self.hb_timers ?? [:]
        if let timer = timers[key] {
            timer?.cancel()
            timers[key] = nil
        }
        timers.removeValue(forKey: key)
        self.hb_timers = timers
        
        if timers.isEmpty { self.hb_timers = nil }
    }
}
