//
//  UITextField+Extension.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/21.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit

//MARK:-- UI扩展 --
extension UITextField{
    
    ///设置placehold颜色
    func setPlaceHolderTextColor(_ color: UIColor) {
        guard let holder = placeholder, !holder.isEmpty else { return }
        self.attributedPlaceholder = NSAttributedString(string: holder, attributes: [.foregroundColor: color])
    }
    
    /// 文本距离左右侧的距离
    ///
    /// - Parameters:
    ///   - leftWidth: 左侧距离
    ///   - rightWidth: 右侧距离
    func distanceSides(_ leftWidth:CGFloat,_ rightWidth:CGFloat? = 0)  {
        //左侧view
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: leftWidth, height: 5))
        leftViewMode = UITextField.ViewMode.always
        
        //右侧view
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: rightWidth!, height: 5))
        rightViewMode = UITextField.ViewMode.always
    }
    
    /// 添加标题
    ///
    /// - Parameters:
    ///   - titleLabel: titleLabel
    ///   - titleWidth: titleWidth
    ///   - padding: 距离右侧输入框的距离
    func addLeftTile(titleLabel:UILabel,titleWidth:CGFloat,padding: CGFloat)  {
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: titleWidth + padding + CGFloat(5), height: 30))
        titleLabel.frame = CGRect(x: 5, y: 0, width: titleWidth, height: 30)
        leftView?.addSubview(titleLabel)
        self.leftViewMode = UITextField.ViewMode.always
        
    }
    
    /// 添加左侧icon
    ///
    /// - Parameters:
    ///   - image: image
    ///   - size: icon的size
    ///   - padding: 距离文本距离
    func addLeftIcon(_ image: UIImage,size:CGSize,padding: CGFloat)  {
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: size.width+2*padding-3, height: size.height))
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: padding, y: 0, width: size.width, height: size.height)
        self.leftView?.addSubview(imageView)
        self.leftViewMode = UITextField.ViewMode.always
    }
    
    /// 添加右侧icon
    ///
    /// - Parameters:
    ///   - image: image
    ///   - size: size
    ///   - padding: padding
    func addRightIcon(_ image: UIImage,size:CGSize,padding: CGFloat)  {
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: size.width+2*padding, height: size.height))
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: padding, y: 0, width: size.width, height: size.height)
        self.rightView?.addSubview(imageView)
        rightViewMode = UITextField.ViewMode.always
        
    }
    
}
