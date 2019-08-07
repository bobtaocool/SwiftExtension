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
}

extension TBBaseNavVC {
    
    func setContents(title : String ,defalutImageName: String ,selectedImageName : String) -> Void {
        self.title = title
        self.tabBarItem.image = UIImage(named: defalutImageName)?.withRenderingMode(.alwaysOriginal)
        self.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
    }
    
}

extension TBBaseNavVC {
    
    
    
    
}
