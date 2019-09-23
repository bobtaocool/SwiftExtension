//
//  TBContansts.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/7.
//  Copyright © 2019 bob. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit
import SwiftyJSON
import SQLite
import Alamofire
import HandyJSON
import RxCocoa
import RxSwift
import SVProgressHUD
import Moya

//屏幕宽高
let TBScreenWidth = UIScreen.main.bounds.width
let TBScreenHeight = UIScreen.main.bounds.height

//是否是刘海屏
let TBISPhoneX = Bool(TBScreenWidth >= 375.0 && TBScreenHeight >= 812.0)

//导航栏高度
let TBNavigationHeight = CGFloat(TBISPhoneX ? 88 : 64)
//状态栏高度
let TBStatusHeight = CGFloat(TBISPhoneX ? 44 : 20)
//tabbar高度
let TBTabbarHeight = CGFloat(TBISPhoneX ? (49+34) : 49)
//顶部安全区域远离高度
let TBTopSafeHeight = CGFloat(TBISPhoneX ? 44 : 0)
//底部安全区域远离高度
let TBBottomSafeHeight = CGFloat(TBISPhoneX ? 34 : 0)

let TBMainColor = UIColor.HEX(0xED5F47)

