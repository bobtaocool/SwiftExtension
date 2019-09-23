//
//  TBShowNetWorkingVC.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/7.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class TBShowNetWorkingVC: TBBaseVC {
    
    let disposeBag = DisposeBag()
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NET"
        view.addSubview(self.tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        let items  = Observable.just([SectionModel(model: "Moya", items: ["req-1","req-2","upload-0","upload-1","upload-2","down-1","down-2"]),
                                                       SectionModel(model: "rxala",items: ["1","2"])])
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String ,String>>.init(configureCell:{(dataSource, tv, index, ele) in
            let cell = tv.dequeueReusableCell(withIdentifier: "cell")!
            cell.textLabel?.text = "\(ele)"
            return cell
        })
        
        dataSource.titleForHeaderInSection = {ds,index in
            return ds.sectionModels[index].model
        }
        
        items.bind(to: self.tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { (index) in
            if index.section == 0 {
                let vc:MoyaVC = MoyaVC()
                vc.moyatype = moya_type(rawValue: index.row)!
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }).disposed(by: disposeBag)
    }

}
