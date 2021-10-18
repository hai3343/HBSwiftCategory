//
//  UIView+Extension.swift
//  HBSwiftCategory
//
//  Created by 胡海兵 on 2021/9/23.
//

import Foundation
import UIKit

@objc  extension UIView {
    
    /// 返回view依赖的viewController
    public var viewController: UIViewController? {
        get {
            var responder = self as UIResponder
            while let nextResponder = responder.next {
                if (responder is UIViewController) {
                    return (responder as! UIViewController)
                }
                responder = nextResponder
            }
            return nil
        }
    }
    
    /// - Parameter aClass: 类的类型
    /// - Returns: 查找aClass类型的subview
    public func findSubView(aClass: AnyClass) -> UIView? {
        for subView in self.subviews {
            if (type(of: subView) === aClass) {
                return subView
            }
        }
        return nil
    }
    
    
    /// 查找aClass类型的superview
    ///
    /// - Parameter aClass: 类的类型
    /// - Returns: 查找aClass类型的superview
    public func  findSuperView(aClass: AnyClass) -> UIView? {
        guard let parentView = self.superview else {
            return nil
        }
        if (type(of: parentView) === aClass) {
            return parentView
        }
        
        return self.findSuperView(aClass: aClass)
    }
    
    // 判断View是不是第一响应者
    public func  findAndResignFirstResponder() -> Bool {
        if self.isFirstResponder {
            self.resignFirstResponder()
            return true
        }
        for v in self.subviews {
            if v.findAndResignFirstResponder() {
                return true
            }
        }
        return false
    }
    
    // 找到当前view的第一响应者
    public func  findFirstResponder() -> UIView? {
        if (self is UITextField || self is UITextView) && self.isFirstResponder{
            return self
        }
        for v: UIView in self.subviews {
            let fv = v.findFirstResponder()
            if fv != nil {
                return fv
            }
        }
        return nil
    }

    /// 根据文字多少计算label的高度
    ///
    /// - Parameters:
    ///   - text: 计算的文字
    ///   - font: 文字的字体大小
    ///   - size: 计算的范围
    /// - Returns: 返回计算好的高度
    class func getLabelTextRectSize(text:String,font:UIFont,size:CGSize) -> CGFloat {
        
        let attributes = [NSAttributedString.Key.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let height:CGFloat = text.boundingRect(with: size, options: option, attributes: attributes, context: nil).size.height
        return height
    }
    /// 设置view的圆角,边框
    ///
    /// - Parameters:
    ///   - view: 当前设置的view
    ///   - borderWidth: 边框值
    ///   - borderColor: 边框颜色
    ///   - cornerRadius: 圆角值
    class func setViewBorder(_ view: UIView, borderWidth: CGFloat, borderColor: UIColor, cornerRadius: CGFloat) {
        
        view.layer.borderColor = borderColor.cgColor
        view.layer.borderWidth = borderWidth
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
    }
    ///设置圆角
    class func setCornerRadius(_ view: UIView,cornerRadius: CGFloat) {
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
    }
    
    
    /// 设置view的圆角
    @IBInspectable var hb_viewCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    /// 设置圆角的颜色
    @IBInspectable  var hb_viewBorderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    /// 圆角的宽
    @IBInspectable  var hb_viewBorderWidth: CGFloat{
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    

    /// 设置view的某一个边角为圆角
   @objc func hb_rectCorner(corner:UIRectCorner,radii:CGSize){
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corner, cornerRadii: radii)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
    
        self.layer.mask = maskLayer
    }
    
    /// 初始化一个view
   @objc convenience init(bgColor:UIColor?,corner:CGFloat=0){
        self.init(frame: CGRect.zero)
        backgroundColor = bgColor
        if corner > 0{
            hb_viewCornerRadius = corner
        }
    }
    
    /// 截取屏幕
   @objc func screenshotToImage()->UIImage?{
        UIGraphicsBeginImageContext(bounds.size)
        if let content = UIGraphicsGetCurrentContext(){
            layer.render(in: content)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        return nil
      
    }
    
    
}

