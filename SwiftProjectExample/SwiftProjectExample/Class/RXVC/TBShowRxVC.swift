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
    
    var dataSource : Array <singleData> = [singleData("参考资料1","https://www.jianshu.com/p/f61a5a988590",false),singleData("参考资料2","https://beeth0ven.github.io/RxSwift-Chinese-Documentation/",false),singleData("UILabel","",true),singleData("UITextFile","",true),singleData("UIButton","",true),singleData("UISwitch","",true)]

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
        
        if model.example {
            
            if model.title == "UILabel"
            {
                let label = RXLabelVC()
                navigationController?.pushViewController(label, animated: true)
            }else if model.title == "UITextFile"
            {
                let textFile = RXTextFileVC()
                navigationController?.pushViewController(textFile, animated: true)
            }else if model.title == "UIButton"
            {
                let button = RXButtonVC()
                navigationController?.pushViewController(button, animated: true)
            }else if model.title == "UISwitch"
            {
                let swi = RXSwitchVC()
                navigationController?.pushViewController(swi, animated: true)
            }
        }else{
            let web = TBWebViewVC.init(urlString: model.url)
            navigationController?.pushViewController(web, animated: true)
            
        }
        
    }
}


