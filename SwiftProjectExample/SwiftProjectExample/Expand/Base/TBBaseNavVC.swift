//
//  TBBaseNavVC.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/7.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit

class TBBaseNavVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.HEX(0xFFFFFF)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
}

extension TBBaseNavVC {
    
    func setContents(title : String ,defalutImageName: String ,selectedImageName : String) -> Void {
        self.title = title
        self.tabBarItem.image = UIImage(named: defalutImageName)?.withRenderingMode(.alwaysOriginal)
        self.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
    }
    
}

extension TBBaseNavVC {
    
    func TB_pushToViewController(viewController: UIViewController ,RemovingVC :UIViewController ,animated: Bool) -> Void {
        
        var viewArry : Array<UIViewController> = self.viewControllers.compactMap{return $0}
        var numArr : Array<Int> = []
        
        for (index ,object) in viewArry.enumerated(){
            if object == RemovingVC {
               numArr.append(index)
                break;
            }
        }
        
        for items in numArr{
            viewArry.remove(at: items)
        }
        
        if viewArry.last != viewController {
            viewArry.append(viewController)
        }
        self.setViewControllers(viewArry, animated: true)
    }
    
    func TB_pushToViewController(viewController: UIViewController ,RemovingVCs :Array<UIViewController> ,animated: Bool) -> Void {
        
        var viewArry : Array<UIViewController> = self.viewControllers.compactMap{return $0}
        var numArr : Array<Int> = []
        
        for (index ,object) in viewArry.enumerated(){

            for removeVC in RemovingVCs{
                
                if object == removeVC {
                    numArr.append(index)
                    break;
                }
            }
        }
        
        for items in numArr{
            viewArry.remove(at: items)
        }
        
        if viewArry.last != viewController {
            viewArry.append(viewController)
        }
        self.setViewControllers(viewArry, animated: true)
        
    }
    
    func TB_pushToViewController(viewController: UIViewController ,RemovingPreviousVCsCount :Int ,animated: Bool) -> Void {
        
        var viewArry : Array<UIViewController> = self.viewControllers.compactMap{return $0}
        for i in 0...RemovingPreviousVCsCount {
            if viewArry.count - 1 - i < 0{
                break
            }
            viewArry.removeLast()
        }
         viewArry.append(viewController)
         self.setViewControllers(viewArry, animated: true)
        
    }
    
}
