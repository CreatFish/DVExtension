//
//  UILabelExtenion.swift
//  Amall
//  UILabel扩展
//  Created by David Yu on 2018/1/11.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation
import UIKit

public extension UILabel {
    
    // MARK:- 给label设置文字设置不同属性,暂支持颜色与字体,示例:label.setDifferentAttWith["示例": UIColor.red]
    public func setDifferentAttWith(_ array: [[String: Any]]) {
        let labelText = self.text! as NSString
        let attribute = NSMutableAttributedString(string: labelText as String)
        for element in array {
            for (key,value) in element {
                let range: NSRange = labelText.range(of: key)
                if value is UIFont {
                    attribute.addAttribute(NSAttributedString.Key.font, value: (value as! UIFont), range: range)
                } else if value is UIColor {
                    attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: (value as! UIColor), range: range)
                }
            }
        }
        self.attributedText = attribute
    }
    
    // MARK:- 给label的text添加中划线
    public func setMidLineWith(text: String) {
        let attr = NSMutableAttributedString(string: text)
        attr.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber(value: 1), range: NSMakeRange(0, attr.length))
        self.attributedText = attr
    }
    
}
