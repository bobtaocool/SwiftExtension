//
//  RXActivityIndicatorViewVC.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/16.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RXActivityIndicatorViewVC: TBBaseVC {

    let disposeBag = DisposeBag()
    
    lazy var swi :UISwitch = {
        let swi = UISwitch(frame: CGRect(x: 50, y: 160, width: 60, height: 30))
        return swi
        
    }()
    
    lazy var activityIndicator :UIActivityIndicatorView = {
        let act = UIActivityIndicatorView.init(style: .gray)
        act.frame = CGRect(x: 50, y: 220, width: 30, height: 30)
        return act
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(swi)
        view.addSubview(activityIndicator)
        
        swi.rx.value
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        swi.rx.value
            .bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
        
//        slider.rx.value.asObservable()
//            .subscribe(onNext: {
//                print("当前值为：\($0)")
//            })
//            .disposed(by: disposeBag)
        
//        stepper.rx.value.asObservable()
//            .subscribe(onNext: {
//                print("当前值为：\($0)")
//            })
//            .disposed(by: disposeBag)
        
//        slider.rx.value
//            .map{ Double($0) }  //由于slider值为Float类型，而stepper的stepValue为Double类型，因此需要转换
//            .bind(to: stepper.rx.stepValue)
//            .disposed(by: disposeBag)
    }
    


}
