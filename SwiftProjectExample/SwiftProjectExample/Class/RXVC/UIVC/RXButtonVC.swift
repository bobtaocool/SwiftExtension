//
//  RXButtonVC.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/15.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RXButtonVC: TBBaseVC {
    
    let disposeBag = DisposeBag()
    lazy var button :UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("点我", for: .normal)
        button.frame = CGRect(x: 50, y: 100, width: 60, height: 40)
        
        return button
    }()
    
    lazy var button1 :UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("点我1", for: .normal)
        button.frame = CGRect(x: 130, y: 100, width: 60, height: 40)
        
        return button
    }()
    
    
    lazy var button2 :UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("点我2", for: .normal)
        button.frame = CGRect(x: 210, y: 100, width: 60, height: 40)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        
        click5()
        
    }
    

}

extension RXButtonVC {
    
    func click() {
        
        button.rx.tap.subscribe(onNext: { [weak self] in
            self?.view.backgroundColor = .yellow
        }).disposed(by: disposeBag)
        
//        button.rx.tap
//            .bind { [weak self] in
//                self?.view.backgroundColor = .red
//            }
//            .disposed(by: disposeBag)
    }
    
    func click2(){
        
        let timer = Observable<Int>.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        timer.map {
            "计数\($0)"
        }.bind(to: button.rx.title(for: .normal))
        .disposed(by: disposeBag)
    }
    
    func click3() {
        
        //创建一个计时器（每1秒发送一个索引数）
        let timer = Observable<Int>.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        
        //将已过去的时间格式化成想要的字符串，并绑定到button上
        timer.map(formatTimeInterval)
            .bind(to: button.rx.attributedTitle())
            .disposed(by: disposeBag)
    }
    
    //将数字转成对应的富文本
    func formatTimeInterval(ms: NSInteger) -> NSMutableAttributedString {
        let string = String(format: "%0.2d:%0.2d.%0.1d",
                            arguments: [(ms / 600) % 600, (ms % 600 ) / 10, ms % 10])
        //富文本设置
        let attributeString = NSMutableAttributedString(string: string)
        //从文本0开始6个字符字体HelveticaNeue-Bold,16号
        attributeString.addAttribute(NSAttributedString.Key.font,
                                     value: UIFont(name: "HelveticaNeue-Bold", size: 16)!,
                                     range: NSMakeRange(0, 5))
        //设置字体颜色
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor,
                                     value: UIColor.white, range: NSMakeRange(0, 5))
        //设置文字背景颜色
        attributeString.addAttribute(NSAttributedString.Key.backgroundColor,
                                     value: UIColor.orange, range: NSMakeRange(0, 5))
        return attributeString
    }
    
    func click4() {
        
        //创建一个计时器（每1秒发送一个索引数）
        let timer = Observable<Int>.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        
        //根据索引数选择对应的按钮图标，并绑定到button上
        timer.map({
            let name = $0%2 == 0 ? "back" : "forward"
            return UIImage(named: name)!
        })
            .bind(to: button.rx.image())
            .disposed(by: disposeBag)
        
        
        
        /*
         
         //创建一个计时器（每1秒发送一个索引数）
         let timer = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
         
         //根据索引数选择对应的按钮背景图，并绑定到button上
         timer.map{ UIImage(named: "\($0%2)")! }
         .bind(to: button.rx.backgroundImage())
         .disposed(by: disposeBag)
         
         switch1.rx.isOn
         .bind(to: button1.rx.isEnabled)
         .disposed(by: disposeBag)
         
         */
        
    }
    
    func click5() {
        view.addSubview(button1)
        view.addSubview(button2)
        
        button.isSelected = true
        
        let buttons = [button ,button1 ,button2].map {$0!}
        
        let selectedButton = Observable.from(
        
            buttons.map{ butt in
                butt.rx.tap.map{ butt
                }
            }).merge()
        
            for b in buttons
            {
                selectedButton.map {
                    $0 == b
                }.bind(to: b.rx.isSelected)
                .disposed(by: disposeBag)
                
            }
        
    }
    
    
}
