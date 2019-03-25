//
//  DoubleExtenion.swift
//  Amall
//  Double扩展
//  Created by David Yu on 2018/1/11.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation

public extension Double {
    
    // MARK:- 格式化成想保留几位的字符串
    public func formatDouble(count: Int) -> String {
        let str = String(format: "%.\(count)f", self)
        return str
    }
    
}

public extension Float {
    
    // MARK:- 格式化成想保留几位的字符串
    public func formatFloat(count: Int) -> String {
        let str = String(format: "%.\(count)f", self)
        return str
    }
    
}
