//
//  TBTabbarController.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/7.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit

class TBTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let uiNav = TBBaseNavVC(rootViewController: TBShowUIVC())
        uiNav.setContents(title: "UI", defalutImageName: "ui", selectedImageName: "ui-selected")
        let jsonNav = TBBaseNavVC(rootViewController: TBShowJsonVC())
        jsonNav.setContents(title: "json", defalutImageName: "jsonfile", selectedImageName: "jsonfile-selected")
        let rxNav = TBBaseNavVC(rootViewController: TBShowRxVC())
        rxNav.setContents(title: "rx", defalutImageName: "RX", selectedImageName: "RX-selected")
        let netVC = TBBaseNavVC(rootViewController: TBShowNetWorkingVC())
        netVC.setContents(title: "net", defalutImageName: "net", selectedImageName: "net-selected")
        let sqlVC = TBBaseNavVC(rootViewController: TBShowSQLVC())
        sqlVC.setContents(title: "sql", defalutImageName: "sql", selectedImageName: "sql-selected")
        let thirdVC = TBBaseNavVC(rootViewController: TBPromiseKitVC())
        thirdVC.setContents(title: "thirdVC", defalutImageName: "sql", selectedImageName: "sql-selected")
        
        self.setViewControllers([uiNav,jsonNav,rxNav,netVC,sqlVC,thirdVC], animated: true)
        
        self.tabBar.tintColor = UIColor.red;
        self.tabBar.barTintColor = UIColor.white;
    }
    
}
