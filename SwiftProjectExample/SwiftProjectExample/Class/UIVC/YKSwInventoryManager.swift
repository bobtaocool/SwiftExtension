//
//  YKSwInventoryManager.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/9/21.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit

class YKSwInventoryManager: TBBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        navTitleRightBtn("调拨记录")
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    lazy var tableView :UITableView = {
        let tab = UITableView.init(frame: .zero, style: .plain)
        tab.delegate = self
        tab.dataSource = self
        tab.separatorStyle = .none
        tab.register(YKSwInventoryCell.self, forCellReuseIdentifier: NSStringFromClass(YKSwInventoryCell.self))
        tab.tableFooterView = YKSwInvenFootView.init(frame: CGRect(x: 0, y: 0, width: TBScreenWidth, height: 76), transfers: {
            
        }, storage: {
            
            let sheet = UIAlertController.init(title: "去入库", message: "", preferredStyle: .actionSheet)
            let comsheet = UIAlertAction.init(title: "普通机入库", style: .default, handler: { (acc) in
                
                
            })
            
            let zibeisheet = UIAlertAction.init(title: "自备机入库", style: .default, handler: { (acc) in
                
                
            })
            
            let canclesheet = UIAlertAction.init(title: "取消", style: .cancel, handler: { (acc) in
                
                
            })
            
            sheet.addAction(comsheet)
            sheet.addAction(zibeisheet)
            sheet.addAction(canclesheet)
            self.present(sheet, animated: true, completion: nil)
        })
        return tab
    }()
    
}

extension YKSwInventoryManager : UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell :YKSwInventoryCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(YKSwInventoryCell.self), for: indexPath) as! YKSwInventoryCell
        
        if indexPath.row == 0 {
            
            let att = NSMutableAttributedString.init(string: "机具总数" + "20")
            att.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 15), range: NSRange(location: 4, length: 2))
            att.addAttribute(.foregroundColor, value: UIColor.HEX(0x333333), range: NSRange(location: 4, length: 2))
            cell.setAttContent(title: "活动机", content: att)
        }else {
            let att = NSMutableAttributedString.init(string: "机具总数" + "20")
            att.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 15), range: NSRange(location: 4, length: 2))
            att.addAttribute(.foregroundColor, value: UIColor.HEX(0x333333), range: NSRange(location: 4, length: 2))
            cell.setAttContent(title: "自备机(押金版)", content: att)
            
        }

        return cell
    }

}

extension YKSwInventoryManager{
    
    override func rightBtnClick() {
        print("hello")
        
    }
    
}
