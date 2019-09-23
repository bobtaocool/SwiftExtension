//
//  ViewModel.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/22.
//  Copyright © 2019 bob. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Result


class ViewModel {
    
    /**** 输入部分 ***/
    fileprivate let searchAction:Observable<String>
    
    /**** 输出部分 ***/
    //所有的查询结果
    let searchResult: Observable<GitHubRepositories>
    
    //查询结果里的资源列表
    let repositories: Observable<[GitHubRepository]>
    
    //清空结果动作
    let cleanResult: Observable<Void>
    
    //导航栏标题
    let navigationTitle: Observable<String>
    
    //ViewModel初始化（根据输入实现对应的输出）
    init(searchAction:Observable<String>) {

        self.searchAction = searchAction
        self.searchResult = searchAction.filter {!$0.isEmpty}
            .flatMapLatest {
                GitHubProvider.rx.request(.repositories($0)).asObservable().mapObject(type: GitHubRepositories.self).catchError({ (error)
                    in
                    return Observable<GitHubRepositories>.empty()
                })
                
        }.share(replay: 1, scope: .forever)
        
        //生成清空结果动作序列
        self.cleanResult = searchAction.filter{ $0.isEmpty }.map{ _ in Void() }
        
        //生成查询结果里的资源列表序列（如果查询到结果则返回结果，如果是清空数据则返回空数组）
        self.repositories = Observable.of(searchResult.map{ $0.items },
                                          cleanResult.map{[]}).merge()
        
        //生成导航栏标题序列（如果查询到结果则返回数量，如果是清空数据则返回默认标题）
        self.navigationTitle = Observable.of(
            searchResult.map{ "共有 \($0.totalCount!) 个结果" },
            cleanResult.map{ "hangge.com" })
            .merge()
                
        }

    
}
