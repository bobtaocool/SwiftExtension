//
//  TBTest3RxVC.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/12.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TBTest3RxVC: TBBaseVC {
    lazy var label : UILabel = {
    let label = UILabel()
        label.frame = CGRect(x: 100, y: 50, width: 100, height: 100)
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        test1()
        test3()
    }
}

extension TBTest3RxVC{
    
    func test1(){
        
        /*
         1，在 subscribe 方法中创建
         （1）创建观察者最直接的方法就是在 Observable 的 subscribe 方法后面描述当事件发生时，需要如何做出响应。
         （2）比如下面的样例，观察者就是由后面的 onNext，onError，onCompleted 这些闭包构建出来的。
         */
        
        let disposeBag = DisposeBag()
        
        let obsevabe = Observable.of("a","b","c")
        obsevabe.subscribe(onNext: { (element) in
            print(element)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("com")
        }).disposed(by: disposeBag)
        
    }
    
    /*
     2，在 bind 方法中创建
     
     （1）下面代码我们创建一个定时生成索引数的 Observable 序列，并将索引数不断显示在 label 标签上：
     */
    func test2(){
        

//        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//        observable.map { hah in
//            print(hah)
//            }.bind { [weak self](text) in
//                self?.label.text = text
//        }
    }
    
    /*
     1，配合 subscribe 方法使用
     */
    
    func test3() {
        let observer :AnyObserver<String> = AnyObserver { (event) in
            switch event{
            case .next(let data):
                print(data)
            case .error(let error):
                print(error)
            case .completed:
                print("completed")
            }

        }
        
        let observable = Observable.of("A", "B", "C")
        observable.subscribe(observer).disposed(by: DisposeBag())
        
    }
    
    /*
     2，配合 bindTo 方法使用
     */
    func test4() {
        
        let disposeBag = DisposeBag()
        
        let observer :AnyObserver<String> = AnyObserver{ [weak self](event) in
            
            switch event {
            case .next(let text):
                //收到发出的索引数后显示到label上
                self?.label.text = text
            default:
                break
            }
            
        }
        
        //Observable序列（每隔1秒钟发出一个索引数）
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        observable.map{"当前索引：\($0)"}.bind(to: observer).disposed(by: disposeBag)
        
    }
    
    
    func test5() {
        
        /*
         四、使用 Binder 创建观察者
         1，基本介绍
         （1）相较于AnyObserver 的大而全，Binder 更专注于特定的场景。Binder 主要有以下两个特征：
         
         不会处理错误事件
         确保绑定都是在给定 Scheduler 上执行（默认 MainScheduler）
         
         （2）一旦产生错误事件，在调试环境下将执行 fatalError，在发布环境下将打印错误信息。
         2，使用样例
         （1）在上面序列数显示样例中，label 标签的文字显示就是一个典型的 UI 观察者。它在响应事件时，只会处理 next 事件，而且更新 UI 的操作需要在主线程上执行。那么这种情况下更好的方案就是使用 Binder。
         （2）上面的样例我们改用 Binder 会简单许多：
         */
        let disposeBag = DisposeBag()
        let observable :Binder<String> = Binder(label){
            (view ,text) in
            view.text = text
        }
        
        let obser = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        obser.map { "当前索引数：\($0 )"}.bind(to: observable).disposed(by: disposeBag)
        
    }
    
}
