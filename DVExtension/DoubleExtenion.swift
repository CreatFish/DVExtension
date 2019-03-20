//
//  DoubleExtenion.swift
//  Amall
//  Double扩展
//  Created by David Yu on 2018/1/11.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation

extension Double {
    
    // MARK:- 格式化成想保留几位的字符串
    func formatDouble(count: Int) -> String {
        let str = String(format: "%.\(count)f", self)
        return str
    }
    
}

extension Float {
    
    // MARK:- 格式化成想保留几位的字符串
    func formatFloat(count: Int) -> String {
        let str = String(format: "%.\(count)f", self)
        return str
    }
    
}
