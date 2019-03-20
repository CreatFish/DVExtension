//
//  UIViewExtenion.swift
//  Amall
//  UIView扩展
//  Created by David Yu on 2018/1/11.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    // MARK:- 清除一所有子view
    func removeAllSubView() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    // MARK:- 在view上画一根1像素的线,真正的1像素
    func drawLineWith(startPoint: CGPoint, endPoint: CGPoint, color: UIColor) {
        //  正确的线宽为1的高度
        let realOneWidth = 1 / UIScreen.main.scale
        //  设置线宽为1时的偏移，使用时 x - kRealOneWidthPffset
        let realOneWidthOffset = (1 / UIScreen.main.scale) / 2
        
        let subLayer = CAShapeLayer()
        subLayer.strokeColor = color.cgColor
        subLayer.lineWidth = realOneWidth
        let path = UIBezierPath()
        path.move(to: CGPoint(x: startPoint.x-realOneWidthOffset, y: startPoint.y))
        path.addLine(to: CGPoint(x: endPoint.x-realOneWidthOffset, y: endPoint.y))
        subLayer.path = path.cgPath
        self.layer.addSublayer(subLayer)
    }
    
    // MARK:- view转图片
    func generateImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()!
        self.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
