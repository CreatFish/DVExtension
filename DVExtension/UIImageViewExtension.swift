//
//  UIImageViewExtension.swift
//  Amall
//  UIImageView扩展
//  Created by David Yu on 2018/6/4.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit

extension UIImageView {
    
    // MARK:- 高效绘制圆角button
    func circleView(cornerRadius: CGFloat) {
        //  正确的线宽为1的高度
        let realOneWidth = 1 / UIScreen.main.scale
        // 开始图形上下文
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            let rect = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            var path: UIBezierPath
            if let color = self.backgroundColor {
                context.setLineWidth(realOneWidth)
                context.setFillColor(color.cgColor)
                context.setStrokeColor(color.cgColor)
            }
            
            if self.frame.size.width == self.frame.size.height {
                if cornerRadius == self.frame.size.width/2 {
                    path = UIBezierPath(arcCenter: self.center, radius: cornerRadius, startAngle: 0, endAngle: 2.0*CGFloat(Double.pi), clockwise: true)
                }else {
                    path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
                }
            }else {
                path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
            }
            self.draw(rect)
            context.addPath(path.cgPath)
            context.drawPath(using: .fillStroke)
            context.clip()
            // 从上下文上获取剪裁后的照片
            guard let uncompressedImage = UIGraphicsGetImageFromCurrentImageContext() else {
                UIGraphicsEndImageContext()
                return
            }
            // 关闭上下文
            UIGraphicsEndImageContext()
//            let view = UIImageView()
//            view.backgroundColor = UIColor.clear
//            view.frame = self.frame
            self.addSubview(UIImageView(image: uncompressedImage))
        }
    }
    
}
