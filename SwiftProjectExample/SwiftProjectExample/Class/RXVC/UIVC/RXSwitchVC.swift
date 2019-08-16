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
    
    
    lazy var seg : UISegmentedControl = {
        
       let se = UISegmentedControl(frame: CGRect(x: 50, y: 240, width: 300, height: 50))
        se.insertSegment(withTitle: "第一个", at: 0, animated: true)
        se.insertSegment(withTitle: "第二个", at: 1, animated: true)
        se.insertSegment(withTitle: "第三个", at: 2, animated: true)
        se.selectedSegmentIndex = 0
        return se
    }()
    
    lazy var label :UILabel = {
        
        let label = UILabel(frame:CGRect(x:50, y:300, width:100, height:30))
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        test2()
        // Do any additional setup after loading the view.
    }

    func test1() {
        view.addSubview(swi)
        view.addSubview(button)
        swi.rx.isOn.bind(to: button.rx.isEnabled).disposed(by: disposeBag)
    }
    
    func test2() {
        view.addSubview(seg)
        view.addSubview(label)
        
        seg.rx.selectedSegmentIndex.map {
            
             "当前项\($0)"
        }.bind(to: label.rx.text)
        .disposed(by: disposeBag)
    }

    func test3() {
        
        //创建一个当前需要显示的图片的可观察序列
//        let showImageObservable: Observable<UIImage> =
//            seg.rx.selectedSegmentIndex.asObservable().map {
//                let images = ["js.png", "php.png", "react.png"]
//                return UIImage(named: images[$0])!
//        }
//
//        //把需要显示的图片绑定到 imageView 上
//        showImageObservable.bind(to: imageView.rx.image)
//            .disposed(by: disposeBag)
    }
    
}
