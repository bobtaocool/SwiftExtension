//
//  TBShowRxVC.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/7.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit

typealias singleData = (title :String ,url: String ,example : Bool)
class TBShowRxVC: TBBaseVC {
    
    var dataSource : Array <singleData> = [singleData("Observable介绍、创建可观察序列","https://www.jianshu.com/p/63f1681236fd",false),singleData("Observable订阅、事件监听、订阅销毁","https://www.jianshu.com/p/4ce3f253dacd",false),singleData("观察者2： AnyObserver、Binder","https://www.jianshu.com/p/87a436448383",false)]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RX"
        view.addSubview(tableView)
        
       
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalTo(self.view)
        }
    }
    
    lazy var tableView :UITableView = {
        let tab = UITableView.init(frame:CGRect.zero, style: .plain)
        tab.delegate = self
        tab.dataSource = self
        tab.rowHeight = UITableView.automaticDimension;
        tab.estimatedRowHeight = 50
        tab.estimatedSectionFooterHeight = 0
        tab.estimatedSectionHeaderHeight = 0
        tab.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tab
    }()
    
}

extension TBShowRxVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}

extension TBShowRxVC :UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(format: "%d", indexPath.row) + model.title
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource[indexPath.row]
        if indexPath.row == 0 {
            let test = TBTestRxVC()
            test.model = model
            navigationController?.pushViewController(test, animated: true)
        }else if indexPath.row == 1{
            let test = TBTest2RxVC()
            test.model = model
            navigationController?.pushViewController(test, animated: true)
        }
    }
}


