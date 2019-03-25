//
//  StringExtenion.swift
//  Amall
//  String扩展
//  Created by David Yu on 2018/1/11.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    
    // MARK:- 显示手机号码，中间四位用*代替
    public func mobileStr() -> String {
        let str = self.prefix(3) + "****" + self.suffix(4)
        return String(str)
    }
    
    // MARK:- 显示银行卡号，中间八位用*代替
    public func bankStr() -> String {
        let str = self.prefix(4) + " **** **** " + self.suffix(4)
        return String(str)
    }
    
    // MARK:- 格式化时间戳，将时间戳转换为日期时间格式显示, tips:format是格式，如"yyyy-MM-dd HH:mm:ss"
    public func formatTime(format: String) -> String {
        let timeInterval:TimeInterval = TimeInterval(self)!
        let date = NSDate(timeIntervalSince1970:timeInterval)
        //格式话输出
        let dformatter = DateFormatter()
        dformatter.dateFormat = format
        return dformatter.string(from: date as Date)
    }
    
    // MARK:- 获取一个字符串需要全部显示出来时需要的尺寸
    public func getSize(_ font: UIFont, size: CGSize) -> CGSize {
        let rect =  (self as NSString).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:font], context: nil)
        let size = rect.size
        return size
    }
    
    // MARK:- 验证手机
    public func vailMobile() -> Bool {
        if (self as NSString).length < 11 {
            return false
        } else {
            //移动正则表达式
            let CM_NUM = "^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$"
            //联通正则表达式
            let CU_NUM = "^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$"
            //电信正则表达式
            let CT_NUM = "^((133)|(153)|(177)|(17[0-9])|(18[0,1,9]))\\d{8}$"
            
            let pred1 = NSPredicate(format: "SELF MATCHES %@", CM_NUM)
            let isMatch1 = pred1.evaluate(with: self)
            let pred2 = NSPredicate(format: "SELF MATCHES %@", CU_NUM)
            let isMatch2 = pred2.evaluate(with: self)
            let pred3 = NSPredicate(format: "SELF MATCHES %@", CT_NUM)
            let isMatch3 = pred3.evaluate(with: self)
            
            if isMatch1 || isMatch2 || isMatch3 {
                return true
            } else {
                return false
            }
        }
    }
    
    // MARK:- 验证邮箱
    public func vailEMail() -> Bool {
        //邮箱正则表达式
        let EMAIL = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let pred = NSPredicate(format: "SELF MATCHES %@", EMAIL)
        let isMatch = pred.evaluate(with: self)
        
        if isMatch {
            return true
        } else {
            return false
        }
    }
    
    // MARK:- 时间转换成刚刚 几分钟前 几小时前等显示,self为时间戳
    public func updateTimeForRow() -> String {
        let currentTime = Date().timeIntervalSince1970
        let creatTime: Double = (self as NSString).doubleValue
        let time: Int = (Int)(currentTime - creatTime)
        var str = ""
        if time < 60 {
            str = "刚刚"
        } else if time/60 < 60 {
            let tmp: Int = time/60
            str = "\(tmp)分钟前"
        } else if time/(60*60) < 24 {
            let tmp: Int = time/(60*60)
            str = "\(tmp)小时前"
        } else if time/(60*60*24) < 30 {
            let tmp: Int = time/(60*60*24)
            str = "\(tmp)天前"
        } else if time/(60*60*24*30) < 12 {
            let tmp: Int = time/(60*60*24*30)
            str = "\(tmp)月前"
        } else {
            let tmp: Int = time/(60*60*24*30*12)
            str = "\(tmp)年前"
        }
        return str
    }
    
    // MARK:- 检测字符串只包含数字与字母
    public func limitAcc() -> Bool {
        let regex = "^[a-zA-Z0-9_]*$";
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: self)
        return isValid
    }
    
    // MARK:- 分割字符串
    public func split(_ s:String)->[String]{
        if s.isEmpty{
            var x=[String]()
            for y in self {
                x.append(String(y))
            }
            return x
        }
        return self.components(separatedBy: s)
    }
    
    // MARK:- 检查是否包含某个字符串
    public func has(_ search:String)->Bool{
        let range = self.range(of: search)
        if range != nil {
            return true
        } else {
            return false
        }
    }
    
}
