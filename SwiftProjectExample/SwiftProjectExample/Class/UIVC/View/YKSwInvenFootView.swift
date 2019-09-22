//
//  YKSwInvenFootView.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/9/21.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit



class YKSwInvenFootView: UIView {

    typealias comonBlock = ()->()
    
    var transBlock :comonBlock?
    var storegeBlock :comonBlock?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect ,transfers: @escaping comonBlock ,storage : @escaping comonBlock) {
        self.init(frame: frame)
        self.addSubview(transfersBtn)
        self.addSubview(self.storageBtn)
        transBlock = transfers
        storegeBlock = storage
        
        transfersBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.top.equalTo(self).offset(26)
            make.height.equalTo(50)
            make.right.equalTo(self.storageBtn.snp_left).offset(-15)
            make.width.equalTo(self.storageBtn.snp_width)
        }
        
        storageBtn.snp.makeConstraints { (make) in
            
            make.left.equalTo(self.transfersBtn.snp_right).offset(15)
            make.top.equalTo(self).offset(26)
            make.height.equalTo(50)
            make.right.equalTo(self).offset(-20)
            make.width.equalTo(self.transfersBtn.snp_width)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var transfersBtn :UIButton = {
       
        let btn = UIButton.init(type: .custom)
        btn.setTitle("去调拨", for: .normal)
        btn.setBackgroundImage(UIImage(named: "ysf_btn_bgimage"), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(transAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var storageBtn :UIButton = {
        
        let btn = UIButton.init(type: .custom)
        btn.setTitle("去入库", for: .normal)
        btn.setBackgroundImage(UIImage(named: "ysf_btn_bgimage"), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(storageAction), for: .touchUpInside)
        return btn
    }()
    
}

extension YKSwInvenFootView {
    
    @objc func transAction() {
        if (transBlock != nil){
            transBlock!()
        }
    }
    @objc func storageAction() {
        if (storegeBlock != nil){
            storegeBlock!()
        }
    }
}
