//
//  RXTextFileVC.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/14.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RXTextFileVC: TBBaseVC {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        test5()
    }
    
    lazy var textfile :UITextField = {
        
        let textFile = UITextField(frame: CGRect(x: 10, y: 80, width: 200, height: 30))
        textFile.borderStyle = .roundedRect
        return textFile
        
    }()
    
    lazy var textfile1 :UITextField = {
        
        let textFile = UITextField(frame: CGRect(x:10, y:150, width:200, height:30))
        textFile.borderStyle = .roundedRect
        return textFile
    }()
    
    lazy var label :UILabel = {
        
        let label = UILabel(frame:CGRect(x:20, y:190, width:300, height:30))
        return label
    }()
    
    lazy var button :UIButton = {
        
        let button =  UIButton(type:.system)
        
        button.frame = CGRect(x:20, y:230, width:40, height:30)
        button.setTitle("提交", for:.normal)
        
        return button
    }()
    
    lazy var textView :UITextView = {
        
        let textView = UITextView(frame: CGRect(x: 10, y: 100, width: 200, height: 80))
       
        return textView
    }()
    

}

extension RXTextFileVC
{
    
    func test1() {
        
         view.addSubview(textfile)
        
        //注意：.orEmpty 可以将 String? 类型的 ControlProperty 转成 String，省得我们再去解包。
         textfile.rx.text.orEmpty.asObservable()
         .subscribe(onNext: {
         print("你输入的是:\($0)")
         }).disposed(by: disposeBag)
         //3）当然我们直接使用 change 事件效果也是一样的。
         textfile.rx.text.orEmpty.changed.subscribe(onNext: {
         print("你输入的是:\($0)")
         }).disposed(by: disposeBag)
    }
    
    func test2() {
        
        view.addSubview(textfile)
        view.addSubview(textfile1)
        view.addSubview(label)
        view.addSubview(button)
        
        let input = textfile.rx.text.orEmpty.asDriver().throttle(DispatchTimeInterval.seconds(Int(0.3)))
        
        input.drive(textfile1.rx.text).disposed(by: disposeBag)
        
        input.map{"当前字数:\($0.count)"}.drive(label.rx.text).disposed(by: disposeBag)
        
        input.map{ $0.count > 5
            }.drive(button.rx.isEnabled).disposed(by: disposeBag)
    }
    
    func test3(){
        
        view.addSubview(textfile)
        view.addSubview(textfile1)
        view.addSubview(label)
        
        Observable.combineLatest(textfile.rx.text.orEmpty, textfile1.rx.text.orEmpty) { (textValue1, textValue2) -> String in
            
            return "你输入的号码是：\(textValue1)-\(textValue2)"
            }.map { $0 }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    
    func test4() {
        
        /*
         1）通过 rx.controlEvent 可以监听输入框的各种事件，且多个事件状态可以自由组合。除了各种 UI 控件都有的 touch 事件外，输入框还有如下几个独有的事件：
         
         editingDidBegin：开始编辑（开始输入内容）
         
         editingChanged：输入内容发生改变
         
         editingDidEnd：结束编辑
         
         editingDidEndOnExit：按下 return 键结束编辑
         
         allEditingEvents：包含前面的所有编辑相关事件
         */
        view.addSubview(textfile)
        view.addSubview(textfile1)
        
//        textfile.rx.controlEvent([.editingDidBegin ,.editingChanged,.editingDidEnd,.editingDidEndOnExit]).asObservable().subscribe(onNext: {
//
//            print("开始")
//        }).disposed(by: disposeBag)
        
        textfile.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: {[weak self] (_) in
            self?.textfile1.becomeFirstResponder()
        }).disposed(by: disposeBag)
        
        textfile1.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { [weak self](_) in
            self?.textfile1.resignFirstResponder()
        }).disposed(by: disposeBag)
    }
    
    
    func test5() {
        
        /*
         （1）UITextView 还封装了如下几个委托回调方法：
         
         didBeginEditing：开始编辑
         didEndEditing：结束编辑
         didChange：编辑内容发生改变
         didChangeSelection：选中部分发生变化
         */
        
        view.addSubview(textView)
        
        textView.rx.didBeginEditing.subscribe(onNext: { (_) in
            print("开始编辑")
        }).disposed(by: disposeBag)
        
        //结束编辑响应
        textView.rx.didEndEditing
            .subscribe(onNext: {
                print("结束编辑")
            })
            .disposed(by: disposeBag)
        
        //内容发生变化响应
        textView.rx.didChange
            .subscribe(onNext: {
                print("内容发生改变")
            })
            .disposed(by: disposeBag)
        
        //选中部分变化响应
        textView.rx.didChangeSelection
            .subscribe(onNext: {
                print("选中部分发生变化")
            })
            .disposed(by: disposeBag)
        
    }
}
