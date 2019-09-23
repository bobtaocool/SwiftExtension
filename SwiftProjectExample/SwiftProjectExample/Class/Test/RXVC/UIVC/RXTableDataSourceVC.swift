//
//  RXTableDataSourceVC.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/16.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


//自定义Section
struct MySection {
    var header: String
    var items: [Item]
}

extension MySection : AnimatableSectionModelType {
    typealias Item = String
    
    var identity: String {
        return header
    }
    
    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }
}

class RXTableDataSourceVC: TBBaseVC {

    var tableView:UITableView!
    let disposeBag = DisposeBag()
    //搜索栏
    var searchBar:UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      navTitleRightBtn("刷新")
      self.customMode2()
        
    }

     func customMode0(){
        
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        //初始化数据
        let items  = Observable.just([SectionModel(model: "基本控件", items: ["UILable的用法","UIText的用法","UIButton的用法"]),
                                      SectionModel(model: "高级控件",items: ["UITableView的用法","UICollectionViews的用法"])])
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String ,String>>.init(configureCell:{ (datasorce, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(indexPath.row)：\(element)"
            return cell
        })
        
        dataSource.titleForHeaderInSection = {
            ds, index in
            return ds.sectionModels[index].model
        }
        items.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
    
    
    
    func customModel(){
        
        
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //初始化数据
        let sections = Observable.just([
            MySection(header: "基本控件", items: [
                "UILable的用法",
                "UIText的用法",
                "UIButton的用法"
                ]),
            MySection(header: "高级控件", items: [
                "UITableView的用法",
                "UICollectionViews的用法"
                ])
            ])
        
        //创建数据源
        let dataSource = RxTableViewSectionedAnimatedDataSource<MySection>(
            //设置单元格
            configureCell: { ds, tv, ip, item in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")
                    ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
                cell.textLabel?.text = "\(ip.row)：\(item)"
                
                return cell
        },
            //设置分区头标题
            titleForHeaderInSection: { ds, index in
                return ds.sectionModels[index].header
        }
        )
        
        //绑定单元格数据
        sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

    }
    
    func customMode2(){
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //随机的表格数据
        let randomResult = self.navigationItem.rightBarButtonItem!.rx.tap.asObservable()
            .throttle(1, scheduler: MainScheduler.instance)// //在主线程中操作，1秒内值若多次改变，取最后一次
            .startWith(()) //加这个为了让一开始就能自动请求一次数据
            .flatMapLatest(getRandomResult)
            .share(replay: 1)
        
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource
            <SectionModel<String, Int>>(configureCell: {
                (dataSource, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "条目\(indexPath.row)：\(element)"
                return cell
            })
        
        //绑定单元格数据
        randomResult
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
    
    
    //获取随机数据
    func getRandomResult() -> Observable<[SectionModel<String, Int>]> {
        print("正在请求数据......")
        let items = (0 ..< 5).map {_ in
            Int(arc4random())
        }
        let observable = Observable.just([SectionModel(model: "S", items: items)])
        return observable.delay(2, scheduler: MainScheduler.instance)
    }
    
    
    /*
     3，防止表格多次刷新的说明
     （1）flatMapLatest 的作用是当在短时间内（上一个请求还没回来）连续点击多次“刷新”按钮，虽然仍会发起多次请求，但表格只会接收并显示最后一次请求。避免表格出现连续刷新的现象。
     //随机的表格数据
     let randomResult = refreshButton.rx.tap.asObservable()
     .startWith(()) //加这个为了让一开始就能自动请求一次数据
     .flatMapLatest(getRandomResult)
     .share(replay: 1)
     
     （2）我们也对源头进行限制下。即通过 throttle 设置个阀值（比如 1 秒），如果在1秒内有多次点击则只取最后一次，那么自然也就只发送一次数据请求。
     //随机的表格数据
     let randomResult = refreshButton.rx.tap.asObservable()
     .throttle(1, scheduler: MainScheduler.instance) //在主线程中操作，1秒内值若多次改变，取最后一次
     .startWith(()) //加这个为了让一开始就能自动请求一次数据
     .flatMapLatest(getRandomResult)
     .share(replay: 1)
     
     */
    
    /*
     在实际项目中我们可能会需要对一个未完成的网络请求进行中断操作。比如切换页面或者分类时，如果上一次的请求还未完成就要将其取消掉。下面通过样例演示如何实现该功能。
       该功能简单说就是通过 takeUntil 操作符实现。当 takeUntil 中的 Observable 发送一个值时，便会结束对应的 Observable。
     //随机的表格数据
     let randomResult = refreshButton.rx.tap.asObservable()
     .startWith(()) //加这个为了让一开始就能自动请求一次数据
     .flatMapLatest{
     self.getRandomResult().takeUntil(self.cancelButton.rx.tap)
     }
     .share(replay: 1)
    */
    
    
    func customModel3(){
        
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //创建表头的搜索栏
        self.searchBar = UISearchBar(frame: CGRect(x: 0, y: 0,
                                                   width: self.view.bounds.size.width, height: 56))
        self.tableView.tableHeaderView =  self.searchBar
        
        //随机的表格数据
        let randomResult = self.navigationItem.rightBarButtonItem!.rx.tap.asObservable()
            .startWith(()) //加这个为了让一开始就能自动请求一次数据
            .flatMapLatest(getRandomResult) //获取数据
            .flatMap(filterResult) //筛选数据
            .share(replay: 1)
        
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource
            <SectionModel<String, Int>>(configureCell: {
                (dataSource, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "条目\(indexPath.row)：\(element)"
                return cell
            })
        
        //绑定单元格数据
        randomResult
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
    }
    
    
    //过滤数据
    func filterResult(data:[SectionModel<String, Int>])
        -> Observable<[SectionModel<String, Int>]> {
            return self.searchBar.rx.text.orEmpty
                //.debounce(0.5, scheduler: MainScheduler.instance) //只有间隔超过0.5秒才发送
                .flatMapLatest{
                    query -> Observable<[SectionModel<String, Int>]> in
                    print("正在筛选数据（条件为：\(query)）")
                    //输入条件为空，则直接返回原始数据
                    if query.isEmpty{
                        return Observable.just(data)
                    }
                        //输入条件为不空，则只返回包含有该文字的数据
                    else{
                        var newData:[SectionModel<String, Int>] = []
                        for sectionModel in data {
                            let items = sectionModel.items.filter{ "\($0)".contains(query) }
                            newData.append(SectionModel(model: sectionModel.model, items: items))
                        }
                        return Observable.just(newData)
                    }
            }
    }
    
}
