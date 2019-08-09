//
//  TBTestRxVC.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/9.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TBTestRxVC: TBBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "测试"
        // Do any additional setup after loading the view.
    }
    

}


extension TBTestRxVC {
    
    func obser1() {
        
        /// （1）该方法通过传入一个默认值来初始化。
        ///（2）下面样例我们显式地标注出了 observable 的类型为 Observable<Int>，即指定了这个 Observable所发出的事件携带的数据类型必须是 Int 类型的。
        let observable0 = Observable<Int>.just(5)
        /*
         （1）该方法可以接受可变数量的参数（必需要是同类型的）
         
         （2）下面样例中我没有显式地声明出 Observable 的泛型类型，Swift 也会自动推断类型。
        */
        let observable1 = Observable.of("A","B","C")
        /*
         （1）该方法需要一个数组参数。
         
         （2）下面样例中数据里的元素就会被当做这个 Observable 所发出 event携带的数据内容，最终效果同上面饿 of()样例是一样的。
         */
        let observable2 = Observable.from(["A","B","C"])
        
        
        /*
         该方法创建一个空内容的 Observable 序列。
         
        */
        let observable3 = Observable<Any>.empty()
        
        /*
         该方法创建一个永远不会发出 Event（也不会终止）的 Observable 序列。
         */
        let observable4 = Observable<Any>.never()
        
        
        /*
         该方法创建一个不做任何操作，而是直接发送一个错误的 Observable 序列。
         */
        
        enum MyError: Error {
            case A
            case B
        }
        
        let observable5 = Observable<Int>.error(MyError.A)
        /*
         （1）该方法通过指定起始和结束数值，创建一个以这个范围内所有值作为初始值的Observable序列。
         
         （2）下面样例中，两种方法创建的 Observable 序列都是一样的。
         */
        let observable6 = Observable.range(start: 1, count: 5)
        
        let observable61 = Observable.of(1,2,3,4,5,6)
        
        /*
         该方法创建一个可以无限发出给定元素的 Event的 Observable 序列（永不终止）。
         
         */
        let observable7 = Observable.repeatElement(1)
        
        /*
         （1）该方法创建一个只有当提供的所有的判断条件都为 true 的时候，才会给出动作的 Observable 序列。
         （2）下面样例中，两种方法创建的 Observable 序列都是一样的。
         */
        let observable8 = Observable.generate(initialState: 0, condition: {$0 <= 10}, iterate: {$0 + 2})
        
        let observable81 = Observable.of(0 , 2 ,4 ,6 ,8 ,10)
        
        
        /*
         （1）该方法接受一个 block 形式的参数，任务是对每一个过来的订阅进行处理。
         
         （2）下面是一个简单的样例。为方便演示，这里增加了订阅相关代码（关于订阅我之后会详细介绍的）。
         */
        let observable9 = Observable<String>.create {(obser)  -> Disposable in
            
            obser.onNext("on next")
            obser.onCompleted()
            
            return Disposables.create()
            
        }
        /*
        （1）该个方法相当于是创建一个 Observable 工厂，通过传入一个 block 来执行延迟 Observable序列创建的行为，而这个 block 里就是真正的实例化序列对象的地方。
         */
        
        //用于标记是奇数、还是偶数
        var isOdd = true
        let bag = DisposeBag()
        
        let observable10 :Observable<Int> = Observable.deferred {
            isOdd = !isOdd
            
            if isOdd {
                return Observable.of(1,3,5,7)
            }else{
                
                return Observable.of(2,4,6,8)
            }
        }
        observable10.subscribe ({ event in
            
            print("\(isOdd)", event)
        }).disposed(by: bag)
        
        
        /*
         （1）这个方法创建的 Observable 序列每隔一段设定的时间，会发出一个索引数的元素。而且它会一直发送下去。
         
         （2）下面方法让其每 1 秒发送一次，并且是在主线程（MainScheduler）发送。
         
         */
        let observable11 = Observable<Int>.interval(1, scheduler: MainScheduler.instance).subscribe({event in
            print(event)
            }
        )
        
        /*
         该方法创建一个永远不会发出 Event（也不会终止）的 Observable 序列。
         */
        let observable12 = Observable<Any>.never()
        
    }
    
    
}
