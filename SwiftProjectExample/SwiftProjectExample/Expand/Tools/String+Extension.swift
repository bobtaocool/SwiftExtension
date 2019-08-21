//
//  String+Extension.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/21.
//  Copyright © 2019 bob. All rights reserved.
//

import Foundation


extension String
{
    subscript(start:Int, length:Int) -> String
    {
        get{
            let index1 = self.index(self.startIndex, offsetBy: start)
            let index2 = self.index(index1, offsetBy: length)
            return String(self[index1..<index2])
        }
        set{
            let tmp = self
            var s = ""
            var e = ""
            for (idx, item) in tmp.enumerated() {
                if(idx < start)
                {
                    s += "\(item)"
                }
                if(idx >= start + length)
                {
                    e += "\(item)"
                }
            }
            self = s + newValue + e
        }
    }
    subscript(index:Int) -> String
    {
        get{
            return String(self[self.index(self.startIndex, offsetBy: index)])
        }
        set{
            let tmp = self
            self = ""
            for (idx, item) in tmp.enumerated() {
                if idx == index {
                    self += "\(newValue)"
                }else{
                    self += "\(item)"
                }
            }
        }
    }
}
