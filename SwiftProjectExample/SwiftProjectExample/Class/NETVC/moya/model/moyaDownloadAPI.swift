//
//  moyaDownloadAPI.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/20.
//  Copyright © 2019 bob. All rights reserved.
//

import Moya

//初始化请求的provider
let MyServiceOneProvider = MoyaProvider<MyServiceOne>()

//请求分类
public enum MyServiceOne {
    case downloadAsset(assetName:String) //下载文件
}

//请求配置
extension MyServiceOne: TargetType {
    //服务器地址
    public var baseURL: URL {
        return URL(string: "http://www.hangge.com")!
    }
    
    //各个请求的具体路径
    public var path: String {
        switch self {
        case let .downloadAsset(assetName):
            return "/assets/\(assetName)"
        }
    }
    
    //请求类型
    public var method: Moya.Method {
        return .get
    }
    
    //请求任务事件（这里附带上参数）
    public var task: Task {
        switch self {
        case .downloadAsset(_):
            return .downloadDestination(DefaultDownloadDestination)
        }
    }
    
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    //请求头
    public var headers: [String: String]? {
        return nil
    }
}

//定义下载的DownloadDestination（不改变文件名，同名文件不会覆盖）
private let DefaultDownloadDestination: DownloadDestination = { temporaryURL, response in
    return (DefaultDownloadDir.appendingPathComponent(response.suggestedFilename!), [])
}

//默认下载保存地址（用户文档目录）
let DefaultDownloadDir: URL = {
    let directoryURLs = FileManager.default.urls(for: .documentDirectory,
                                                 in: .userDomainMask)
    return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
}()
