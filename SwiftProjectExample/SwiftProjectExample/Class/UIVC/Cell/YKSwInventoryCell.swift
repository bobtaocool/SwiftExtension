//
//  YKSwInventoryCell.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/9/21.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit

class YKSwInventoryCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        selectionStyle = .none
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    func setContent(title : String ,content : String) -> Void {
        
        titleLabel.text = title
        contentLabel.text = content
    }
    
    func setAttContent(title : String ,content : NSMutableAttributedString) -> Void {
        titleLabel.text = title
        contentLabel.attributedText = content
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel :UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.HEX(0x000000)
        label.textAlignment = .left
        return label
    }()
    
    lazy var contentLabel :UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.HEX(0xA3A3A3)
        label.textAlignment = .right
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(self.contentView).offset(20)
            make.top.equalTo(self.contentView).offset(20)
            make.right.equalTo(self.contentLabel.snp_left).offset(-20)
            make.height.equalTo(17)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView).offset(-20)
            make.top.equalTo(self.contentView).offset(20)
            make.left.equalTo(self.titleLabel.snp_right).offset(20)
            make.height.equalTo(17)
        }
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        contentLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        contentLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
}
