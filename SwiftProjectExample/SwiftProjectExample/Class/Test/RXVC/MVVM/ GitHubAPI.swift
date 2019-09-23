//
//   GitHubAPI.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/22.
//  Copyright © 2019 bob. All rights reserved.
//

import Foundation
import Moya

//初始化GitHub请求的provider
let GitHubProvider = MoyaProvider<GitHubAPI>()

/** 下面定义GitHub请求的endpoints（供provider使用）**/
//请求分类
public enum GitHubAPI{
    case repositories(String)  //查询资源库
}

extension GitHubAPI :TargetType {
    public var sampleData: Data {
         return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        print("发起请求。")
        switch self {
        case .repositories(let query):
            var params: [String: Any] = [:]
            params["q"] = query
            params["sort"] = "stars"
            params["order"] = "desc"
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    
    public var baseURL: URL{
        return URL(string: "https://api.github.com")!
    }
    
    public var path: String{
        
        switch self {
        case .repositories:
            return "/search/repositories"
        }
        
    }
    
    public var method: Moya.Method
    {
        return .get
    }
   
}

