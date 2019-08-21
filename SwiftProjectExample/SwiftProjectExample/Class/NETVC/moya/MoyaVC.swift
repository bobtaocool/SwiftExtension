//
//  MoyaVC.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/20.
//  Copyright © 2019 bob. All rights reserved.
// http://www.hangge.com/blog/cache/detail_1806.html

import UIKit
import SwiftyJSON

public enum moya_type : Int {
    case request1 = 0
    case request2 = 1
    case upload0 = 2
    case upload1 = 3
    case upload2 = 4
    case download1 = 5
    case download2 = 6
}

class MoyaVC: TBBaseVC {
    
    var moyatype : moya_type = .request1
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        switch moyatype {
        case .request1:
            test1()
        case .request2:
            test2()
            
        case .upload0:
            test3()
            
        case .upload1:
            test4()
        case .upload2:
            test5()
        case .download1:
            test6()
        case .download2:
            test7()
        }
        
        // Do any additional setup after loading the view.
    }
    
    func test1() {
        
        DouBanProvider.request(.channels) { (result) in
            
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print("\(json["channels"])")
                
            }
        }
        
    }
    
    func test2() {
        
        Network.request(.channels, success: { (json:JSON) in
            
            print(json["channels"])
            
        }, error: { (error) in
            
        }, failure: {_ in
            
        })
    }
    func test3() {
        
        //需要上传的文件
        let fileURL = Bundle.main.url(forResource: "hangge", withExtension: "zip")!
        //通过Moya提交数据
        MyServiceProvider.request(.upload(fileURL: fileURL)) {
            result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapString()
                print(data ?? "")
            }
        }
    }
    
    // MARK: 业务处理相关方法（上方不带分割线）
    func test4() {
        
        // TODO: 需要记录操作日志
        
        //需要上传的文件
        let fileURL = Bundle.main.url(forResource: "hangge", withExtension: "zip")!
        //通过Moya提交数据
        MyServiceProvider.request(.upload(fileURL: fileURL), progress:{
            progress in
            //实时打印出上传进度
            print("当前进度: \(progress.progress)")
        }) {
            result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapString()
                print(data ?? "")
            }
        }
        
    }
    
    // MARK: - 数据请求相关方法（上方会带个分割线）
    func test5() {
        
        // FIXME: 参数不正确时会导致崩溃
        
        //需要上传的文件
        let fileURL = Bundle.main.url(forResource: "hangge", withExtension: "zip")!
        //通过Moya提交数据
        MyServiceProvider.request(.upload1(fileURL: fileURL, fileName: "test.zip")) {
            result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapString()
                print(data ?? "")
            }
        }
        
        
        /*
         //需要上传的文件
         let file1URL = Bundle.main.url(forResource: "hangge", withExtension: "png")!
         let file1Data = try! Data(contentsOf: file1URL)
         let file2URL = Bundle.main.url(forResource: "h", withExtension: "png")!
         //通过Moya提交数据
         MyServiceProvider.request(.uploadFile(value1: "hangge", value2: 10,
         file1Data: file1Data, file2URL: file2URL)) {
         result in
         if case let .success(response) = result {
         //解析数据
         let data = try? response.mapString()
         print(data ?? "")
         
            }
            MyServiceProvider.requestNormal(.uploadFile(value1: "hangge", value2: 10,
                                                        file1Data: file1Data, file2URL: file2URL), callbackQueue: .main, progress: { (progress) in
                                                            
            }, completion: { (result) in
                
                
                
            })
         */
            
    }
    
    
    func test6() {
        
        //要下载的图片名称
        let assetName = "logo.png"
        //通过Moya进行下载
        MyServiceOneProvider.request(.downloadAsset(assetName: assetName)) { result in
            switch result {
            case .success:
                let localLocation: URL = DefaultDownloadDir.appendingPathComponent(assetName)
                let image = UIImage(contentsOfFile: localLocation.path)
                print("下载完毕！保存地址：\(localLocation)")
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    func test7() {
        
        //要下载的图片名称
        let assetName = "logo.png"
        //通过Moya进行下载
        MyServiceOneProvider.request(.downloadAsset(assetName: assetName), progress:{
            progress in
            //实时打印出下载进度
            print("当前进度: \(progress.progress)")
        }) { result in
            switch result {
            case .success:
                let localLocation: URL = DefaultDownloadDir.appendingPathComponent(assetName)
                let image = UIImage(contentsOfFile: localLocation.path)
                print("下载完毕！保存地址：\(localLocation)")
            case let .failure(error):
                print(error)
            }
        }
    }

}
