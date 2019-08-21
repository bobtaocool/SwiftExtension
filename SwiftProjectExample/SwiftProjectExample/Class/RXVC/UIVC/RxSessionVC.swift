//
//  RxSessionVC.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/19.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire

class RxSessionVC: TBBaseVC {
    let disposeBag = DisposeBag()
    var tableView:UITableView!
    
    lazy var button :UIButton = {
        
        let button =  UIButton(type:.system)
        
        button.frame = CGRect(x:20, y:230, width:100, height:30)
        button.setTitle("提交请求", for:.normal)
        
        return button
    }()
    
    lazy var button1 :UIButton = {
        
        let button =  UIButton(type:.system)
        
        button.frame = CGRect(x:20, y:300, width:100, height:30)
        button.setTitle("取消请求", for:.normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        test18()
    }
    
    //1，通过 rx.response 请求数据
    func test1() {
        
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        //创建并发起请求
        URLSession.shared.rx.response(request: request).subscribe(onNext: {
            (response, data) in
            //数据处理
            //判断响应结果状态码
            if 200 ..< 300 ~= response.statusCode {
                let str = String(data: data, encoding: String.Encoding.utf8)
                print("请求成功！返回的数据是：", str ?? "")
            }else{
                print("请求失败！")
            }
        }).disposed(by: disposeBag)
        
    }
    
    //2，通过 rx.data 请求数据
    /*
     rx.data 与 rx.response 的区别：
     
     如果不需要获取底层的 response，只需知道请求是否成功，以及成功时返回的结果，那么建议使用 rx.data。
     因为 rx.data 会自动对响应状态码进行判断，只有成功的响应（状态码为 200~300）才会进入到 onNext 这个回调，否则进入 onError 这个回调。
     */
    
     func test2() {
        
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        //创建并发起请求
        URLSession.shared.rx.data(request: request).subscribe(onNext: {
            data in
            let str = String(data: data, encoding: String.Encoding.utf8)
            print("请求成功！返回的数据是：", str ?? "")
        }, onError: { error in
            print("请求失败！错误原因：", error)
        }).disposed(by: disposeBag)
    }
    
    
    func test3() {
        
        view.addSubview(button)
        view.addSubview(button1)
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        
        button.rx.tap.asObservable().flatMap{
            
            URLSession.shared.rx.data(request: request).takeUntil(self.button1.rx.tap)
            
        }
            .subscribe(onNext: { (data) in
                
                let str = String(data: data, encoding: String.Encoding.utf8)
                print("请求成功！返回的数据是：", str ?? "")
                
            }, onError: { (error) in
                 print("请求失败！错误原因：", error)
            }).disposed(by: disposeBag)
        
    }
    
    /*
     （1）如果服务器返回的数据是 json 格式的话，我们可以使用iOS 内置的 JSONSerialization 将其转成 JSON 对象，方便我们使用。
     */
    func test4() {
        
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        //创建并发起请求
        URLSession.shared.rx.data(request: request).subscribe(onNext: {
            data in
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                as! [String: Any]
            print("--- 请求成功！返回的如下数据 ---")
            print(json!)
        }).disposed(by: disposeBag)
    }
    
    //当然我们在订阅前就进行转换也是可以的：
    func test5() {
        
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        //创建并发起请求
        URLSession.shared.rx.data(request: request)
            .map {
                try JSONSerialization.jsonObject(with: $0, options: .allowFragments)
                    as! [String: Any]
            }
            .subscribe(onNext: {
                data in
                print("--- 请求成功！返回的如下数据 ---")
                print(data)
            }).disposed(by: disposeBag)
        
    }
    //（3）还有更简单的方法，就是直接使用 RxSwift 提供的 rx.json 方法去获取数据，它会直接将结果转成 JSON 对象。
    func test6() {
        
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        //创建并发起请求
        URLSession.shared.rx.json(request: request).subscribe(onNext: {
            data in
            let json = data as! [String: Any]
            print("--- 请求成功！返回的如下数据 ---")
            print(json )
        }).disposed(by: disposeBag)
    }
    
    func test7() {
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        //获取列表数据
        let data = URLSession.shared.rx.json(request: request)
            .map{ result -> [[String: Any]] in
                if let data = result as? [String: Any],
                    let channels = data["channels"] as? [[String: Any]] {
                    return channels
                }else{
                    return []
                }
        }
        
        //将数据绑定到表格
        data.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(row)：\(element["name"]!)"
            return cell
            }.disposed(by: disposeBag)
    }
    
    func test8() {
        
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        URLSession.shared.rx.json(request: request).mapObject(type: Douban.self).subscribe(onNext: { (douban:Douban) in
            
            if let channels = douban.channels {
                print("--- 共\(channels.count)个频道 ---")
                for channel in channels {
                    if let name = channel.name, let channelId = channel.channelId {
                        print("\(name) （id:\(channelId)）")
                    }
                }
            }
            
        }).disposed(by: disposeBag)
        
    }
    
    
    func test9() {
        
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        //获取列表数据
        let data = URLSession.shared.rx.json(request: request)
            .mapObject(type: Douban.self)
            .map{ $0.channels ?? []}
        
        //将数据绑定到表格
        data.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(row)：\(element.name!)"
            return cell
            }.disposed(by: disposeBag)
    }
    
    //使用 request 请求数据
    func test10() {
        
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)!
        
        request(.get, url).data().subscribe(onNext: { (data) in
            //数据处理
            let str = String(data: data, encoding: String.Encoding.utf8)
            print("返回的数据是：", str ?? "")
            
        }, onError: { (error) in
             print("请求失败！错误原因：", error)
            
        }).disposed(by: disposeBag)
        
        
    }
    //使用 requestData 请求数据
    func test11() {
        
        //创建URL对象
        let urlString = "https://www.douban.com/jxxxxxxx/app/radio/channels"
        let url = URL(string:urlString)!
        
        //创建并发起请求
        requestData(.get, url).subscribe(onNext: {
            response, data in
            //判断响应结果状态码
            if 200 ..< 300 ~= response.statusCode {
                let str = String(data: data, encoding: String.Encoding.utf8)
                print("请求成功！返回的数据是：", str ?? "")
            }else{
                print("请求失败！")
            }
        }).disposed(by: disposeBag)
        
        
    }
    //3，获取 String 类型数据
    func test12() {
        
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)!
        
        //创建并发起请求
        request(.get, url)
            .responseString()
            .subscribe(onNext: {
                response, data in
                //数据处理
                print("返回的数据是：", data)
            }).disposed(by: disposeBag)
        
        
        /*
         （2）当然更简单的方法就是直接使用 requestString 去获取数据。
         //创建URL对象
         let urlString = "https://www.douban.com/j/app/radio/channels"
         let url = URL(string:urlString)!
         
         //创建并发起请求
         requestString(.get, url)
         .subscribe(onNext: {
         response, data in
         //数据处理
         print("返回的数据是：", data)
         }).disposed(by: disposeBag)
         */
    }
    
    
    func test13() {
        view.addSubview(button)
        view.addSubview(button1)
        
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)!
        
        //发起请求按钮点击
        button.rx.tap.asObservable()
            .flatMap {
                request(.get, url).responseString()
                    .takeUntil(self.button1.rx.tap) //如果“取消按钮”点击则停止请求
            }
            .subscribe(onNext: {
                response, data in
                print("请求成功！返回的数据是：", data)
            }, onError: { error in
                print("请求失败！错误原因：", error)
            }).disposed(by: disposeBag)
        
    }
    
    //（1）如果服务器返回的数据是 json 格式的话，我们可以使用 iOS 内置的 JSONSerialization 将其转成 JSON 对象，方便我们使用。
    func test14() {
        
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)!
        
        //创建并发起请求
        request(.get, url)
            .data()
            .subscribe(onNext: {
                data in
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    as! [String: Any]
                print("--- 请求成功！返回的如下数据 ---")
                print(json!)
            }).disposed(by: disposeBag)
        
    }
    //我们换种方式，在订阅前使用 responseJSON() 进行转换也是可以的：
    func test15() {
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)!
        
        //创建并发起请求
        request(.get, url)
            .responseJSON()
            .subscribe(onNext: {
                dataResponse in
                let json = dataResponse.value as! [String: Any]
                print("--- 请求成功！返回的如下数据 ---")
                print(json)
            }).disposed(by: disposeBag)
    }
    //（3）当然最简单的还是直接使用 requestJSON 方法去获取 JSON 数据。
    func test16() {
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)!
        
        //创建并发起请求
        requestJSON(.get, url)
            .subscribe(onNext: {
                response, data in
                let json = data as! [String: Any]
                print("--- 请求成功！返回的如下数据 ---")
                print(json)
            }).disposed(by: disposeBag)
    }
    
    func test17() {
        
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)!
        
        //获取列表数据
        let data = requestJSON(.get, url)
            .map{ response, data -> [[String: Any]] in
                if let json = data as? [String: Any],
                    let channels = json["channels"] as? [[String: Any]] {
                    return channels
                }else{
                    return []
                }
        }
        data.bind(to: tableView.rx.items){
            (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(row)：\(element["name"]!)"
            return cell
        }.disposed(by: disposeBag)
        
    }
    
    func test18() {
        
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)!
        
        //获取列表数据
        let data = requestJSON(.get, url)
            .map{$1}
            .mapObject(type: Douban.self)
            .map{ $0.channels ?? []}
        
        //将数据绑定到表格
        data.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(row)：\(element.name!)"
            return cell
            }.disposed(by: disposeBag)
    }
    
  
}
