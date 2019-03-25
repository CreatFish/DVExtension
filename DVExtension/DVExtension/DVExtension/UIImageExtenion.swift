//
//  UIImageExtenion.swift
//  Amall
//  UIImage扩展
//  Created by David Yu on 2018/1/11.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    
    // MARK:- 颜色生成图片
    public static func imageFromColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    // MARK:- 裁剪图片
    public func clipImageInRect(_ rect: CGRect) -> UIImage {
        let imageRef = self.cgImage?.cropping(to: rect)
        let thumbScale = UIImage(cgImage: imageRef!)
        
        return thumbScale
    }
    
    // MARK:- 自适应裁剪,等比例裁剪尽可能大的图片
    public func clipAspectFit(_ size: CGSize) -> UIImage {
        if size.width > self.size.width || size.height > self.size.height {
            print("要裁剪的大小大于图片尺寸!")
            //缩放系数
            let scaleX: CGFloat = size.width / self.size.width
            let scaleY: CGFloat = size.height / self.size.height
            //取系数小的一个
            let needScale = scaleX <= scaleY ? scaleX : scaleY
            let newSize = CGSize(width: needScale*size.width, height: needScale*size.height)
            var startX: CGFloat = 0
            var startY: CGFloat = 0
            
            startX = (self.size.width - newSize.width)*0.5
            startY = (self.size.height - newSize.height)*0.5
            
            //取真实像素尺寸,如从asset里的图片有2x3x，size并不是真实像素大小
            let scaleW = ((CGFloat)(self.cgImage?.width ?? 0) / self.size.width)
            let scaleH = ((CGFloat)(self.cgImage?.height ?? 0) / self.size.height)
            let finalSize = CGSize(width: scaleW*newSize.width, height: scaleH*newSize.height)
            
            return self.clipImageInRect(CGRect(origin: CGPoint(x: startX, y: startY), size: finalSize))
        } else {
            //缩放系数
            let scaleX: CGFloat = self.size.width / size.width
            let scaleY: CGFloat = self.size.height / size.height
            //取系数小的一个
            let needScale = scaleX <= scaleY ? scaleX : scaleY
            
            var startX: CGFloat = 0
            var startY: CGFloat = 0
            
            let newSize = CGSize(width: needScale*size.width, height: needScale*size.height)
            startX = (self.size.width - newSize.width)*0.5
            startY = (self.size.height - newSize.height)*0.5
            
            //取真实像素尺寸,如从asset里的图片有2x3x，size并不是真实像素大小
            let scaleW = ((CGFloat)(self.cgImage?.width ?? 0) / self.size.width)
            let scaleH = ((CGFloat)(self.cgImage?.height ?? 0) / self.size.height)
            let finalSize = CGSize(width: scaleW*newSize.width, height: scaleH*newSize.height)
            
            return self.clipImageInRect(CGRect(origin: CGPoint(x: startX, y: startY), size: finalSize))
        }
    }
    
    // MARK:- 缩放图片
    public func OriginImage(size: CGSize) -> UIImage{
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    // MARK:- 生成二维码
    public static func createQRForString(qrString: String?, qrImageName: String?) -> UIImage?{
        if let sureQRString = qrString{
            let stringData = sureQRString.data(using: String.Encoding.utf8, allowLossyConversion: false)
            //创建一个二维码的滤镜
            let qrFilter = CIFilter(name: "CIQRCodeGenerator")
            qrFilter?.setValue(stringData, forKey: "inputMessage")
            qrFilter?.setValue("H", forKey: "inputCorrectionLevel")
            let qrCIImage = qrFilter?.outputImage
            
            // 创建一个颜色滤镜,黑白色
            let colorFilter = CIFilter(name: "CIFalseColor")!
            colorFilter.setDefaults()
            colorFilter.setValue(qrCIImage, forKey: "inputImage")
            colorFilter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
            colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
            // 返回二维码image
            let codeImage = UIImage(ciImage: (colorFilter.outputImage!.transformed(by: CGAffineTransform(scaleX: 5, y: 5))))
            
            // 中间一般放logo
            if let iconImage = UIImage(named: qrImageName!) {
                let rect = CGRect(x: 0, y: 0, width: codeImage.size.width, height: codeImage.size.height)
                
                //  不带UIScreen.main.scale会模糊
                UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
                codeImage.draw(in: rect)
                let avatarSize = CGSize(width: 40, height: 40)
                
                let x = (rect.width - avatarSize.width) * 0.5
                let y = (rect.height - avatarSize.height) * 0.5
                iconImage.draw(in: CGRect(x: x, y: y, width: avatarSize.width, height: avatarSize.height))
                
                let resultImage = UIGraphicsGetImageFromCurrentImageContext()
                
                UIGraphicsEndImageContext()
                return resultImage
            }
            return codeImage
        }
        return nil
    }
    
    // MARK:- 压缩图片
    public func zipImage() -> UIImage? {
        
        var data = self.jpegData(compressionQuality: 1.0)
        if data?.count ?? 0 > 1024*1024 {
            data = self.jpegData(compressionQuality: 0.1)
        } else if data?.count ?? 0 > 512*1024 {
            data = self.jpegData(compressionQuality: 0.5)
        } else if data?.count ?? 0 > 200*1024 {
            data = self.jpegData(compressionQuality: 0.9)
        }
        let image = UIImage(data: data ?? Data())
        return image
    }

}
