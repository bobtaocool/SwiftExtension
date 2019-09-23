//
//  TBLoginVC.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/27.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit

class TBLoginVC: TBBaseVC {

    var showDefault : Array<(String,String)> = [("请输入用户名",""),("请输入密码",""),("请确认输入密码","")]
    
    
    lazy var userNameTF : UITextField = {
    let textfile = UITextField(frame: .zero)
    textfile.placeholder = self.showDefault.first?.0
    textfile.borderStyle = .roundedRect
    textfile.returnKeyType = .next
    return textfile
    }()
    
    lazy var pwdTF : UITextField = {
        let textfile = UITextField(frame: .zero)
        textfile.placeholder = self.showDefault[1].0
        textfile.borderStyle = .roundedRect
        textfile.returnKeyType = .next
        return textfile
    }()
    
    lazy var pwdSecondTF : UITextField = {
        let textfile = UITextField(frame: .zero)
        textfile.placeholder = self.showDefault[2].0
        textfile.borderStyle = .roundedRect
        textfile.returnKeyType = .done
        return textfile
    }()
    
    lazy var userNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = TBMainColor
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    lazy var pwdLabel : UILabel = {
        let label = UILabel()
        label.textColor = TBMainColor
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    lazy var pwdSecondLabel : UILabel = {
        let label = UILabel()
        label.textColor = TBMainColor
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "登录"
        view.addSubview(userNameTF)
        view.addSubview(userNameLabel)
        view.addSubview(pwdTF)
        view.addSubview(pwdLabel)
        view.addSubview(pwdSecondTF)
        view.addSubview(pwdSecondLabel)
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        userNameTF.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(TBNavigationHeight + 30)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.height.equalTo(40)
        }
        
        userNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.userNameTF.snp.bottom).offset(2)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.height.equalTo(20)
            
        }
        
        pwdTF.snp.makeConstraints { (make) in
            make.top.equalTo(self.userNameLabel.snp.bottom).offset(5)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.height.equalTo(40)
        }
        
        pwdLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.pwdTF.snp.bottom).offset(2)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.height.equalTo(20)
            
        }
        
        
        pwdSecondTF.snp.makeConstraints { (make) in
            make.top.equalTo(self.pwdLabel.snp.bottom).offset(5)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.height.equalTo(40)
        }
        
        pwdSecondLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.pwdSecondTF.snp.bottom).offset(2)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.height.equalTo(20)
        }
    }
    
}
