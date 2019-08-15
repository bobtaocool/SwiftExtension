//
//  RXSwitchVC.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/15.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RXSwitchVC: TBBaseVC {

    let disposeBag = DisposeBag()
    lazy var button :UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("点我", for: .normal)
        button.frame = CGRect(x: 50, y: 100, width: 60, height: 40)
        
        return button
    }()
    
    lazy var swi :UISwitch = {
       let swi = UISwitch(frame: CGRect(x: 50, y: 160, width: 60, height: 30))
        return swi
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(swi)
        view.addSubview(button)
        swi.rx.isOn.bind(to: button.rx.isEnabled).disposed(by: disposeBag)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
