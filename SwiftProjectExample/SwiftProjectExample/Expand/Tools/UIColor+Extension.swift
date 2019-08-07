//
//  UIColor+Extension.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/7.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit

func RGBA(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) ->UIColor{
    return UIColor(red: r/225.0, green: g/225.0, blue: b/225.0, alpha: a)
}

func RGB(r:CGFloat,g:CGFloat,b:CGFloat) ->UIColor{
    return UIColor(red: r/225.0, green: g/225.0, blue: b/225.0, alpha: 1.0)
}

extension UIColor{
    
    public static func RGBA(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
 
    public static func RGB(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        return UIColor(red: r/225.0, green: g/225.0, blue: b/225.0, alpha: 1.0)
    }
    
    public static func HexWithInt(hex: UInt32 ,alpha : CGFloat) -> UIColor {
        return UIColor(red: CGFloat((hex >> 16) & 0xFF)/255.0 , green:  CGFloat((hex >> 8) & 0xFF)/255.0, blue:  CGFloat(hex & 0xFF)/255.0, alpha: alpha)
    }
    
    public static func HexWithString(hexString : String ,alpha: CGFloat) -> UIColor{
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = Int(formatted, radix: 32) {
            let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
            let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
            let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
            return UIColor(red:red , green: green, blue: blue, alpha: alpha)
        }else{
            return UIColor.white
        }
    }
    
    public static func HEX(_ hex: uint) -> UIColor{
        return HexWithInt(hex: hex, alpha: 1.0)
    }
    
}
