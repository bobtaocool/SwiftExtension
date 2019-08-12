//
//  TBTest4RxVC.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/12.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TBTest4RxVC: TBBaseVC {
    lazy var label : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 100, y: 50, width: 100, height: 100)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}


extension TBTest4RxVC {
    
    func test() {
        
        let disposeBag = DisposeBag()
        
        override func viewDidLoad() {
            
            //Observable序列（每隔0.5秒钟发出一个索引数）
            let observable = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
            observable
                .map { CGFloat($0) }
                .bind(to: label.fontSize) //根据索引数不断变放大字体
                .disposed(by: disposeBag)
        }
        
    }
    
}

extension UILabel {
    
    public var fontSize :Binder <CGFloat>{
        
        return Binder(self) { label,fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
        
    }
    
}
