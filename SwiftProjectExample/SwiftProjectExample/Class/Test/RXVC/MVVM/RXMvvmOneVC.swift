//
//  RXMvvmOneVC.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/16.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct UserViewModel {
    
    let username = BehaviorRelay(value: "guest")
    
    //用户信息
    lazy var userinfo = {
        
        return self.username.asObservable().map{
            $0 == "manager" ? "您是管理员" : "您是普通访客"
        }.share(replay: 1, scope: .forever)
        
    }()
    
}

class RXMvvmOneVC: TBBaseVC {

    @IBOutlet weak var textfile: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    var userVM = UserViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //将用户名与textField做双向绑定
        /*
        userVM.username.asObservable().bind(to: textfile.rx.text).disposed(by: disposeBag)

        textfile.rx.text.orEmpty.bind(to: userVM.username).disposed(by: disposeBag)
         //将用户信息绑定到label上
        userVM.userinfo.bind(to: label.rx.text).disposed(by: disposeBag)
        */
        bindSecond()
    }


    func bindSecond(){
        //将用户名与textField做双向绑定
        _ =  self.textfile.rx.textInput <->  self.userVM.username
        
        //将用户信息绑定到label上
        userVM.userinfo.bind(to: label.rx.text).disposed(by: disposeBag)
        
    }

}
