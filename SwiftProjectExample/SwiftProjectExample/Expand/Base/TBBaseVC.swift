//
//  TBBaseVC.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/7.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit

class TBBaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navBackBtn("nav_back_black")
    }
    
}

extension UIViewController
{
    /// 右边按钮
    ///
    /// - Parameter imageName: 图片名
    func navImageRightBtn(_ imageName : String) -> Void {
        
        let btn = UIBarButtonItem.init(image: UIImage(named: imageName), style: UIBarButtonItem.Style.plain, target: self, action:#selector(self.rightBtnClick));
        
        self.navigationItem.rightBarButtonItem = btn;
        
    }
    
    /// 右边按钮
    ///
    /// - Parameter title: 文字
    func navTitleRightBtn(_ title : String) -> Void {
        
        let btn = UIBarButtonItem.init(title: title, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.rightBtnClick));
        
        self.navigationItem.rightBarButtonItem = btn;
        
    }
    
    /// 右侧点击事件，子类重写
    @objc func rightBtnClick() -> Void {
        
    }
    
    
    /// 左侧按钮
    ///
    /// - Parameter imageName: 按钮图片
    func navImageLeftBtn(_ imageName : String) -> Void {
        
        let btn = UIBarButtonItem.init(image: UIImage(named: imageName), style: UIBarButtonItem.Style.plain, target: self, action:#selector(self.leftBtnClick));
        
        self.navigationItem.leftBarButtonItem = btn;
    }
    
    
    /// 右侧按钮
    ///
    /// - Parameter title: 按钮文字
    func navTitleLeftBtn(_ title : String) -> Void {
        
        let btn = UIBarButtonItem.init(title: title, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.leftBtnClick));
        
        self.navigationItem.leftBarButtonItem = btn;
        
    }
    
    /// 左侧点击事件，子类重写
    @objc func leftBtnClick() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func navBackBtn(_ imageName : String) -> Void {
        let btn = UIBarButtonItem.init(title: "", style: .plain, target: self, action: #selector(self.leftBtnClick))
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: imageName)
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: imageName)
        btn.tintColor = .black
        self.navigationItem.backBarButtonItem = btn;
        
    }
}

