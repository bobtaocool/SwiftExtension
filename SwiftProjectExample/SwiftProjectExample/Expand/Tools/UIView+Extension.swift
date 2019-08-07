//
//  UIView+Extension.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/7.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit

extension UIView {
    /// 宽
    public var width: CGFloat {
        return self.bounds.size.width
    }
    /// 高
    public var height: CGFloat {
        return self.bounds.size.height
    }
    /// left
    public var left: CGFloat {
        return self.frame.origin.x
    }
    /// top
    public var top: CGFloat {
        return self.frame.origin.y
    }
    /// bottom
    public var bottom:CGFloat{
        return top+height
    }
    /// right
    public var right:CGFloat{
        return left+width
    }
    
    /// centerX
    public var centerX: CGFloat {
        return self.center.x
    }
    /// centerY
    public var centerY: CGFloat {
        return self.center.y
    }
    /// size
    public var size : CGSize {
        return self.frame.size
    }
    /// origin
    public var origin : CGPoint {
        return self.frame.origin
    }
    
}


extension UIView {
    
    /// 移除所有子视图
    public func removeAllChildView() {
        _ = self.subviews.map {
            $0.removeFromSuperview()
        }
    }
    /// 设置圆角
    public func addCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    /// 设置边框
    public func addBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
    }
    ///设置顶部边框
    public func addBorderTop(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: frame.width, height: size, color: color)
    }
    /// 设置底部边框
    public func addBorderBottom(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: frame.height - size, width: frame.width, height: size, color: color)
    }
    /// 设置左侧边框
    public func addBorderLeft(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: size, height: frame.height, color: color)
    }
    /// 设置右侧边框
    public func addBorderRight(size: CGFloat, color: UIColor) {
        addBorderUtility(x: frame.width - size, y: 0, width: size, height: frame.height, color: color)
    }
    
    fileprivate func addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
    
}

extension UIView {
    
    public func snapshotImage () -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, isOpaque, 0);
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img!
    }
    
    public func snapshotImage (_ afterUpdates : Bool) ->UIImage {
        
        if !responds(to: #selector(drawHierarchy(in:afterScreenUpdates:))){
            return self.snapshotImage()
        }
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
        
    }
}
