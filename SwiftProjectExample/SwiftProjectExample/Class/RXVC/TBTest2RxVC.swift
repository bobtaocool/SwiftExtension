//
//  TBTest2RxVC.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/11.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TBTest2RxVC: TBBaseVC {

    var model :singleData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "测试"
//        obser1()
//        test2()
        test3()
        navTitleRightBtn("参考")

        // Do any additional setup after loading the view.
    }
    

}



extension TBTest2RxVC {
    
    func obser1() {
        
        /// 订阅 Observable
        /*
         初始化 Observable 序列时设置的默认值都按顺序通过 .next 事件发送出来。
         当 Observable 序列的初始数据都发送完毕，它还会自动发一个 .completed 事件出来。
         */
        let obser = Observable.of("A","B","C")
        obser.subscribe { (event) in
            print(event)
            print(event.element)
        }
        //（2）如果想要获取到这个事件里的数据，可以通过 event.element 得到。
 
    }
    
    func test2() {
        /*
         第二种用法：
         （1）RxSwift 还提供了另一个 subscribe方法，它可以把 event 进行分类：
         
         通过不同的 block 回调处理不同类型的 event。（其中 onDisposed 表示订阅行为被 dispose 后的回调，这个我后面会说）
         同时会把 event 携带的数据直接解包出来作为参数，方便我们使用。
         */
        
         let obser = Observable.of("A","B","C")
        
        obser.subscribe(onNext: { (event) in
            print(event)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("完成")
        }) {
            print("disposed")
        }
        
        //（2）subscribe() 方法的 onNext、onError、onCompleted 和 onDisposed 这四个回调 block 参数都是有默认值的，即它们都是可选的。所以我们也可以只处理 onNext而不管其他的情况。
        
        obser.subscribe(onNext: { element in
            print(element)
        })
        
    }
    //六、监听事件的生命周期
    func test3() {
        /*（1）我们可以使用 doOn 方法来监听事件的生命周期，它会在每一次事件发送前被调用。
         （2）同时它和 subscribe 一样，可以通过不同的block 回调处理不同类型的 event。比如：
         
         
         do(onNext:)方法就是在subscribe(onNext:) 前调用
         而 do(onCompleted:) 方法则会在 subscribe(onCompleted:) 前面调用。
        。*/
        
        let observable = Observable.of("A", "B", "C")
        observable.do(onNext: { (element) in
            print("Intercepted Next：", element)
        }, afterNext: { (element) in
            print("after Next：", element)
        }, onError: { (error) in
            print("error：", error)
        }, afterError: { (error) in
             print("afterError：", error)
        }, onCompleted: {
            print("完成")
        }, afterCompleted: {
            print("完成f后")
        }, onSubscribe: {
             print("onSubscribe")
        }, onSubscribed: {
             print("onSubscribed")
        }) {
            print("disop")
        }
        observable.subscribe(onNext: { (element) in
             print(element)
        }, onError: { (error) in
             print(error)
        }, onCompleted: {
            print("completed")
        }) {
            print("disposed")
        }
    }
    
}

extension TBTest2RxVC {
    
    override func rightBtnClick() {
        
        let web = TBWebViewVC.init(urlString: model!.url)
        navigationController?.pushViewController(web, animated: true)
        
    }
    
}
