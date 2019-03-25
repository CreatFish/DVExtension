//
//  UIColorExtenion.swift
//  Amall
//  UIColor扩展
//  Created by David Yu on 2018/1/11.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    
    // MARK:- 用数值初始化颜色，便于生成设计图上标明的十六进制颜色
    public convenience init(color0xToRGB: UInt, alpha: CGFloat) {
        self.init(
            red: CGFloat((color0xToRGB & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((color0xToRGB & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(color0xToRGB & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
}
