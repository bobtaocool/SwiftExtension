//
//  RXLabelVC.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/14.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RXLabelVC: TBBaseVC {
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        //创建文本标签
        let label = UILabel(frame:CGRect(x:20, y:40, width:300, height:100))
        self.view.addSubview(label)
        
        let timer = Observable<Int>.interval(DispatchTimeInterval.seconds(Int(0.1)), scheduler: MainScheduler.instance)
        timer.map{
            String(format: "%0.2d:%.2d.%.1d", arguments: [($0/3600),($0 % 3600 ) / 60, $0 % 60])
            
        }.bind(to: label.rx.text)
        .disposed(by: disposeBag)
        
        
    }
    

}
