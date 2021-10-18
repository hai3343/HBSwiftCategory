//
//  UIView+Frame.swift
//  HBSwiftCategory
//
//  Created by 胡海兵 on 2021/9/23.
//

import Foundation
import UIKit

// MARK: - 增加是否在当前显示的窗口
extension UIView {

    public func isShowingnKeyWindow() -> Bool {

        guard let keyWindow = UIApplication.shared.keyWindow else {
            return false
        }

        //以主窗口的左上角为原点, 计算self的矩形框(谁调用这个方法这个self就是谁)
        let frame = keyWindow.convert(self.frame, from: self.superview)


        //判断主窗口的bounds和self的范围是否有重叠
        let isIntersects = frame.intersects(keyWindow.bounds)
        return isIntersects && !self.isHidden && self.alpha > 0 && self.window == keyWindow
    }
}
extension UIView {
   
    // x
    var x: CGFloat {
        get {
            return frame.origin.x;
        }
        set(x) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x = x
            frame = tempFrame
        }
    }
    
    // y
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set(y) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y = y
            frame = tempFrame
        }
    }
    
    // height
    var height: CGFloat {
        get {
            return frame.height
        }
        set(height) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = height
            frame = tempFrame
        }
    }
    
    // width
    var width: CGFloat {
        get {
            return frame.width
        }
        set(width) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = width
            frame = tempFrame
        }
    }
    
    // origin
    var origin: CGPoint {
        get {
            return frame.origin
        }
        set(newPoint) {
            var newframe: CGRect = frame
            newframe.origin = newPoint
            frame = newframe
        }
    }
    
    // size
    var size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    // centerX
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    // centerY
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }
    
    // top
    var top: CGFloat {
        get {
            return frame.origin.y
        }
        set(newTop) {
            var newFrame = frame;
            newFrame.origin.y = newTop;
            frame = newFrame;
        }
    }
    
    // left
    var left: CGFloat {
        get {
            return frame.origin.x
        }
        set(newLeft) {
            var newFrame = frame;
            newFrame.origin.x = newLeft;
            frame = newFrame;
        }
    }

    // bottom
    var bottom: CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
        set(newBottom) {
            var newFrame = frame;
            newFrame.origin.y = newBottom - frame.size.height;
            frame = newFrame;
        }
    }
    
    // bottomLeft
    
    public var bottomLeft: CGPoint{
        get{
            let x = self.frame.origin.x
            let y = self.frame.origin.y + self.frame.size.height
            return CGPoint.init(x: x, y: y)
        }
    }
    
    // bottomRight
    
    public var bottomRight: CGPoint{
        get{
            let x = self.frame.origin.x + self.frame.size.width
            let y = self.frame.origin.y + self.frame.size.height
            return CGPoint.init(x: x, y: y)
        }
    }

    // right
    var right: CGFloat {
        get {
            return frame.origin.x + frame.size.width
        }
        set(newRight) {
            let delta = newRight - (frame.origin.x + frame.size.width);
            var newFrame = frame;
            newFrame.origin.x += delta ;
            self.frame = newFrame;
        }
    }
    
    // topRight
    public var topRight: CGPoint{
        get{
            let x = self.frame.origin.x + self.frame.size.width
            let y = self.frame.origin.y
            return CGPoint.init(x: x, y: y)
        }
    }

}

